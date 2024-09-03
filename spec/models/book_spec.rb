require "rails_helper"

RSpec.describe Book, type: :model do
  let(:book) { FactoryBot.create(:book) }

  context "associations" do
    it { should have_many(:reviews) }
  end

  context "validations" do
    it "is valid with valid attributes" do
      expect(book).to be_valid
    end

    it "is not valid without a title" do
      book.title = nil
      expect(book).not_to be_valid
    end
  end

  context "field normalization" do
    it "normalize title and subtitle" do
      book = Book.create({ title: "Journey  to Hogwarts  ", subtitle: " Lorem   ipsum dolor   sit amet  " })
      expect(book.title).to eq("Journey to Hogwarts")
      expect(book.subtitle).to eq("Lorem ipsum dolor sit amet")

      book = Book.create({ title: "Journey  to Hogwarts  ", subtitle: nil })
      expect(book.subtitle).to be_nil
    end
  end

  context "when there are no reviews" do
    it "returns nil" do
      expect(book.rating_statistics).to be_nil
    end
  end

  context "when there are reviews" do
    before do
      FactoryBot.create(:review, book: book, rating: 1)
      FactoryBot.create(:review, book: book, rating: 1)
      FactoryBot.create(:review, book: book, rating: 2)
      FactoryBot.create(:review, book: book, rating: 3)
      FactoryBot.create(:review, book: book, rating: 4)
      FactoryBot.create(:review, book: book, rating: 5)
    end

    it "returns a hash with rating statistics" do
      statistics = book.rating_statistics
      expect(statistics).to be_a(Hash)
      expect(statistics[:total]).to eq(6)
      expect(statistics[:rating_1]).to eq({ rating: 1, count: 2, perc: 33 })
      expect(statistics[:rating_2]).to eq({ rating: 2, count: 1, perc: 17 })
      expect(statistics[:rating_3]).to eq({ rating: 3, count: 1, perc: 17 })
      expect(statistics[:rating_4]).to eq({ rating: 4, count: 1, perc: 17 })
      expect(statistics[:rating_5]).to eq({ rating: 5, count: 1, perc: 17 })
    end
  end

  context "when the total count is zero" do
    before do
      FactoryBot.create(:review, book: book, rating: 1)
      FactoryBot.create(:review, book: book, rating: 1)
    end

    it "returns the correct percentages" do
      statistics = book.rating_statistics
      Rails.logger.info statistics
      expect(statistics[:rating_1][:perc]).to eq(100)
      expect(statistics[:rating_2][:perc]).to eq(0)
      expect(statistics[:rating_3][:perc]).to eq(0)
      expect(statistics[:rating_4][:perc]).to eq(0)
      expect(statistics[:rating_5][:perc]).to eq(0)
    end
  end
end
