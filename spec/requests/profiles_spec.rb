require "rails_helper"

RSpec.describe "Profiles", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET /profile" do
    it "render show page when the user is logged in" do
      sign_in user, scope: :user
      get profile_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end

    it "it redirects when the user is not logged in" do
      get profile_path
      expect(response).to redirect_to new_user_session_path
    end
  end
end
