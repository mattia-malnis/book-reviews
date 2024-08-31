class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book, touch: true

  broadcasts_refreshes

  validates :title, :description, presence: true
  validates :rating, numericality: { in: 1..5 }

  before_validation :normalize_fields

  default_scope { order(created_at: :desc) }

  private

  def normalize_fields
    self.title = title.try(:squish)
  end
end
