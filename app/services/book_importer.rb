class BookImporter
  MAX_RETRIES = 3

  def initialize(big_book_service = BigBook.new)
    @offset = 0
    @retry_count = 0
    @big_book_service = big_book_service
  end

  def import
    quota_left = Float::INFINITY

    while quota_left.positive?
      begin
        books_data = @big_book_service.list_books(@offset)
        process_books(books_data[:items])

        @offset += books_data[:items].size
        quota_left = books_data[:quota_left]

        Rails.logger.info("Imported #{@offset} books. Quota left: #{quota_left}")
        @retry_count = 0
      rescue ApiError, JsonParseError => e
        @retry_count += 1
        if @retry_count <= MAX_RETRIES
          Rails.logger.warn("Error occurred: #{e.message}. Retrying... (#{@retry_count}/#{MAX_RETRIES})")
          sleep(2**@retry_count) # Exponential backoff
          retry
        else
          Rails.logger.error("Max retries reached. Stopping import.")
          break
        end
      end
    end

    schedule_image_processing
  end

  private

  def process_books(list)
    return if list.blank?

    books = build_books(list)
    Book.upsert_all(books)
  end

  def build_books(list)
    return if list.blank?

    list.map do |item|
      {
        external_ref: item[:id],
        title: item[:title],
        subtitle: item[:subtitle],
        temp_image_url: item[:image_url]
      }
    end
  end

  def schedule_image_processing
    Book.select(:id).where.not(temp_image_url: [ nil, "" ]).find_each do |book|
      BookImageProcessingJob.perform_later(book.id)
    end
    Rails.logger.info("Scheduled image processing for books")
  end
end
