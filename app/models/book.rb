class Book < ApplicationRecord
  include ImageUploadable

  validates :title, presence: true

  before_validation :normalize_fields

  private

  def normalize_fields
    self.title = title.try(:squish)
    self.subtitle = subtitle.try(:squish)
  end
end
