require "rails_helper"

RSpec.describe Review, type: :model do
  let(:review) { FactoryBot.create(:review) }

  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end

  context "validations" do
    it "is valid with valid attributes" do
      expect(review).to be_valid
    end

    it "is not valid without a title" do
      review.title = nil
      expect(review).not_to be_valid
    end

    it "is not valid without a description" do
      review.description = nil
      expect(review).not_to be_valid
    end

    it "is not valid without a validrating" do
      review.rating = nil
      expect(review).not_to be_valid
      review.rating = 6
      expect(review).not_to be_valid
    end

    it "is not valid without a user" do
      review.user = nil
      expect(review).not_to be_valid
    end

    it "is not valid without a book" do
      review.book = nil
      expect(review).not_to be_valid
    end
  end

  context "field normalization" do
    let(:user) { FactoryBot.create(:user) }
    let(:book) { FactoryBot.create(:book) }

    it "normalize title" do
      review = Review.create({ title: "  Review  title ", description: "Text", rating: 4, user:, book: })
      expect(review.title).to eq("Review title")
    end
  end
end
