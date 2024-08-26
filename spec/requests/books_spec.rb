require "rails_helper"

RSpec.describe "Books", type: :request do
  let!(:book1) { FactoryBot.create(:book, title: "Ruby on Rails Guide") }
  let!(:book2) { FactoryBot.create(:book, title: "JavaScript for Beginners") }
  let!(:book3) { FactoryBot.create(:book, title: "Ruby Programming") }

  describe "GET /index" do
    context 'when no search query is provided' do
      it "returns all books" do
        get root_path
        expect(assigns(:books)).to include(book1, book2, book3)
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
      end
    end

    context "when a search query is provided" do
      it "returns only the books matching the query" do
        get root_path, params: { query: "Ruby" }
        expect(assigns(:books)).to include(book1, book3)
        expect(assigns(:books)).not_to include(book2)
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
      end

      it "returns no books if no match is found" do
        get root_path, params: { query: "Rust" }
        expect(assigns(:books)).to be_empty
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
      end
    end
  end
end
