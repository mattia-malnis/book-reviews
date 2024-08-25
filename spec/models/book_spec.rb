require "rails_helper"

RSpec.describe Book, type: :model do
  let(:book) { FactoryBot.create(:book) }

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
end
