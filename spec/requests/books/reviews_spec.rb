require "rails_helper"

RSpec.describe "Books::Reviews", type: :request do
  let(:book) { FactoryBot.create(:book) }
  let(:user) { FactoryBot.create(:user) }
  let(:review) { FactoryBot.create(:review, user:) }

  describe "GET /books/:book_id/reviews/new" do
    it "render new review page" do
      sign_in user
      get new_book_review_path(book)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe "POST /books/:book_id/reviews" do
    let(:review_params) { { review: { title: "Great book", description: "I enjoyed it!", rating: 5 } } }

    context "when format is HTML" do
      it "creates a new review and redirects to the book page" do
        sign_in user
        post book_reviews_path(book), params: review_params
        expect(response).to redirect_to(book_path(book))
      end
    end

    context "when format is turbo_stream" do
      it "creates a new review and renders the Turbo Stream response" do
        sign_in user
        post book_reviews_path(book), params: review_params, as: :turbo_stream
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:create)
      end
    end

    it "renders the new template if the review creation fails" do
      sign_in user
      post book_reviews_path(book), params: { review: { title: "Great book" } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:new)
    end
  end

  describe "GET /books/:book_id/reviews/:id/edit" do
    it "render edit review page" do
      sign_in user
      get edit_book_review_path(review.book, review)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH /books/:book_id/reviews/:id" do
    let(:review_params) { { review: { title: "New title" } } }

    context "when format is HTML" do
      it "updates a the review and redirects to the book page" do
        sign_in user
        patch book_review_path(review.book, review), params: review_params
        review.reload
        expect(review.title).to eq(review_params[:review][:title])
        expect(response).to redirect_to(book_path(review.book))
      end
    end

    context "when format is turbo_stream" do
      it "updates a the review and renders the Turbo Stream response" do
        sign_in user
        patch book_review_path(review.book, review), params: review_params, as: :turbo_stream
        review.reload
        expect(review.title).to eq(review_params[:review][:title])
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:update)
      end
    end

    it "renders the edit template if the review update fails" do
      sign_in user
      patch book_review_path(review.book, review), params: { review: { title: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:edit)
    end
  end

  context "authorization" do
    let(:user2) { FactoryBot.create(:user) }

    it "redirects non-owner user to the book page when trying to edit a review" do
      sign_in user2
      get edit_book_review_path(review.book, review)
      expect(response).to redirect_to book_path(review.book)
    end

    it "redirects the user if they try to update a review they do not own" do
      sign_in user2
      patch book_review_path(review.book, review), params: { review: { title: "New Title" } }
      expect(response).to redirect_to book_path(review.book)
    end
  end

  context "authentication" do
    it "allows logged in user to access the new review page" do
      sign_in user
      get new_book_review_path(book)
      expect(response).to have_http_status(:success)
    end

    it "redirect if the user is not logged in and want to leave a review" do
      get new_book_review_path(book)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
