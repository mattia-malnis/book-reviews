require "rails_helper"

RSpec.describe User, type: :model do
  context "associations" do
    it { should have_many(:reviews) }
    it { should have_many(:votes) }
  end

  context "field normalization" do
    it "normalize nickname" do
      user = User.create({ email: "test@test.com", password: "12345678", nickname: "My   nickname " })
      expect(user.nickname).to eq("My nickname")
    end
  end

  context "votes" do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:review) { FactoryBot.create(:review, user: user2) }
    let!(:vote) { FactoryBot.create(:vote, user: user1, review:) }

    it "allows a user to vote on a review that is not their own" do
      expect(user1.can_vote_review?(review)).to be_truthy
    end

    it "prevents a user from voting on their own review" do
      expect(user2.can_vote_review?(review)).to be_falsey
    end

    it "returns the user's vote for a specific review" do
      expect(user1.get_vote_for_review(review)).to eq(vote)
    end

    it "returns nil if the user hasn't voted on a review" do
      expect(user2.get_vote_for_review(review)).to be_nil
    end
  end
end
