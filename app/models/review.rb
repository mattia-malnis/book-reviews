class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :title, :description, presence: true
  validates :rating, numericality: { in: 1..5 }

  before_validation :normalize_fields

  private

  def normalize_fields
    self.title = title.try(:squish)
  end
end
