require "rails_helper"

RSpec.describe Vote, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:review) }
  end

  context "validations" do
    let(:review) { FactoryBot.create(:review) }
    let(:vote) { FactoryBot.create(:vote) }

    it "is valid with valid attributes" do
      expect(vote).to be_valid
    end

    it "is not valid with wrong vote_type" do
      vote.vote_type = nil
      expect(vote).not_to be_valid
    end

    it "is not valid when the same user votes on the same review twice" do
      new_vote = Vote.new({ user: vote.user, review: vote.review, vote_type: :like })
      expect(new_vote).not_to be_valid
    end

    it "is not valid when user vote his review" do
      invalid_vote = Vote.new({ user: review.user, review: review, vote_type: :like })
      expect(invalid_vote).not_to be_valid
    end
  end
end
