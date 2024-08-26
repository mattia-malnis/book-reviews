require "rails_helper"

RSpec.describe BookImporter do
  let(:big_book_service) { instance_double(BigBook) }
  let(:book_importer) { described_class.new(big_book_service) }

  describe "#import" do
    let(:books_data) do
      {
        items: [
          { id: 1, title: "Book 1", subtitle: "Subtitle 1", image_url: "http://example.com/1.jpg" },
          { id: 2, title: "Book 2", subtitle: "Subtitle 2", image_url: "http://example.com/2.jpg" }
        ],
        quota_left: 20
      }
    end

    context "when the import is successful" do
      before do
        allow(big_book_service).to receive(:list_books).and_return(books_data)
        allow(Book).to receive(:upsert_all)
        allow(book_importer).to receive(:schedule_image_processing)
      end

      it "imports the books" do
        # On the second call returns `quota_left: 0` to avoid a loop
        allow(big_book_service).to receive(:list_books).and_return(books_data, { items: [], quota_left: 0 })
        book_importer.import

        expect(Book).to have_received(:upsert_all).with(
          [
            { external_ref: 1, title: "Book 1", subtitle: "Subtitle 1", temp_image_url: "http://example.com/1.jpg" },
            { external_ref: 2, title: "Book 2", subtitle: "Subtitle 2", temp_image_url: "http://example.com/2.jpg" }
          ]
        )
        expect(book_importer).to have_received(:schedule_image_processing)
      end
    end

    context "when an error occurs during the import" do
      before do
        allow(big_book_service).to receive(:list_books).and_raise(ApiError, "API error")
        allow(book_importer).to receive(:sleep)
      end

      it "retries the import up to MAX_RETRIES times and logs the retries" do
        expect(Rails.logger).to receive(:warn)
                                .with(/Error occurred: API error. Retrying.../)
                                .exactly(BookImporter::MAX_RETRIES).times
        expect(Rails.logger).to receive(:error).with("Max retries reached. Stopping import.")

        book_importer.import
      end
    end

    context "when no books are returned" do
      before do
        allow(big_book_service).to receive(:list_books).and_return({ items: [], quota_left: 0 })
        allow(book_importer).to receive(:schedule_image_processing)
      end

      it "does not attempt to upsert books or schedule image processing" do
        expect(Book).not_to receive(:upsert_all)
        book_importer.import
      end
    end
  end
end
