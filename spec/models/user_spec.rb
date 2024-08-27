require "rails_helper"

RSpec.describe User, type: :model do
  context "associations" do
    it { should have_many(:reviews) }
  end

  context "field normalization" do
    it "normalize nickname" do
      user = User.create({ email: "test@test.com", password: "12345678", nickname: "My   nickname " })
      expect(user.nickname).to eq("My nickname")
    end
  end
end
