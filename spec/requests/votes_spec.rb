require "rails_helper"

RSpec.describe "Votes", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:review) { FactoryBot.create(:review) }

  shared_examples "vote toggle action" do |vote_type|
    it "toggles the vote and updates the counter" do
      sign_in user
      expect {
        post send("toggle_#{vote_type}_review_path", review), as: :turbo_stream
      }.to change { review.reload.send("#{vote_type}_count") }.by(1)

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:toggle_vote)

      # Simulate toggling vote off
      expect {
        post send("toggle_#{vote_type}_review_path", review), as: :turbo_stream
      }.to change { review.reload.send("#{vote_type}_count") }.by(-1)

      expect(response).to have_http_status(:success)
    end

    it "does not allow a user to vote without authentication" do
      post send("toggle_#{vote_type}_review_path", review), as: :turbo_stream
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST /reviews/:id/vote-toggle-like" do
    it_behaves_like "vote toggle action", "like"
  end

  describe "POST /reviews/:id/vote-toggle-dislike" do
    it_behaves_like "vote toggle action", "dislike"
  end
end
