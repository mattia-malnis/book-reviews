require "rails_helper"

RSpec.describe BigBook do
  let(:service) { described_class.new }

  before do
    WebMock.disable_net_connect!
  end

  describe "#list_books" do
    let(:api_url) { "#{BigBook::BASE_URL}/search-books?number=100&offset=0" }

    context "when the API responds successfully" do
      before do
        stub_request(:get, api_url)
          .to_return(
            status: 200,
            body: {
              books: [
                [ { id: 1, title: "Book 1", subtitle: "Subtitle 1", image: "http://example.com/1.jpg" } ],
                [ { id: 2, title: "Book 2", subtitle: "Subtitle 2", image: "http://example.com/2.jpg" } ]
              ]
            }.to_json,
            headers: { "Content-Type" => "application/json", "X-Api-Quota-Left" => "38" }
          )
      end

      it "returns a list of books and quota_left" do
        result = service.list_books

        expect(result[:items][0][:title]).to eq("Book 1")
        expect(result[:quota_left]).to eq(38)
      end
    end

    context "when the API responds with an error" do
      before do
        stub_request(:get, api_url).to_return(status: 500, body: "", headers: {})
      end

      it "raises an ApiError" do
        expect { service.list_books }.to raise_error(ApiError)
      end
    end

    context "when the response is malformed JSON" do
      before do
        stub_request(:get, api_url).to_return(status: 200, body: "malformed json", headers: { "Content-Type" => "application/json" })
      end

      it "raises a JsonParseError" do
        expect { service.list_books }.to raise_error(JsonParseError)
      end
    end
  end
end
