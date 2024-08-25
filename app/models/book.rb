class Book < ApplicationRecord
  validates :title, presence: true

  before_validation :normalize_fields

  private

  def normalize_fields
    self.title = title.try(:squish)
    self.subtitle = subtitle.try(:squish)
  end
end
