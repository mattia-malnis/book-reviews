require "rails_helper"

RSpec.describe "Profiles::Reviews", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:review) { FactoryBot.create(:review, user:) }

  describe "GET /profile/reviews/:id/edit" do
    it "render edit review page" do
      sign_in user, scope: :user
      get edit_profile_review_path(review)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH /profile/reviews/:id" do
    let(:review_params) { { review: { title: "New title" } } }

    context "when format is HTML" do
      it "updates a the review and redirects to the profile page" do
        sign_in user, scope: :user
        patch profile_review_path(review), params: review_params
        review.reload
        expect(review.title).to eq(review_params[:review][:title])
        expect(response).to redirect_to(profile_path)
      end
    end

    context "when format is turbo_stream" do
      it "updates the review and renders the Turbo Stream response" do
        sign_in user, scope: :user
        patch profile_review_path(review), params: review_params, as: :turbo_stream
        review.reload
        expect(review.title).to eq(review_params[:review][:title])
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:update)
      end
    end

    it "renders the edit template if the review update fails" do
      sign_in user, scope: :user
      patch profile_review_path(review), params: { review: { title: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:edit)
    end
  end

  context "authorization" do
    let(:user2) { FactoryBot.create(:user) }

    it "redirects non-owner user to the root page when trying to edit a review" do
      sign_in user2, scope: :user
      get edit_book_review_path(review.book, review)
      expect(response).to redirect_to root_path
    end

    it "redirects the user if they try to update a review they do not own" do
      sign_in user2, scope: :user
      patch profile_review_path(review), params: { review: { title: "New Title" } }
      expect(response).to redirect_to root_path
    end
  end

  context "authentication" do
    it "redirect if the user is not logged in and want to edit a review" do
      get edit_profile_review_path(review)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
