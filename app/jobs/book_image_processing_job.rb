class BookImageProcessingJob < ApplicationJob
  queue_as :default

  def perform(book_id)
    book = Book.find_by(id: book_id)

    if book.nil?
      Rails.logger.error("Book with ID #{book_id} not found")
      return
    end

    begin
      book.attach_image_from_url
    rescue StandardError => e
      Rails.logger.error("Failed to process image for book ID #{book_id}: #{e.message}")
      raise e
    end
  end
end
