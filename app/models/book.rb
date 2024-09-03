class Book < ApplicationRecord
  include PgSearch::Model
  include ImageUploadable

  has_many :reviews, dependent: :destroy

  validates :title, presence: true

  before_validation :normalize_fields

  pg_search_scope :search_books,
                  using: {
                    tsearch: {
                      dictionary: "english",
                      tsvector_column: "textsearchable_col"
                    }
                  }

  def cache_ratings_average
    update ratings_avg: reviews.average(:rating)
  end

  private

  def normalize_fields
    self.title = title.try(:squish)
    self.subtitle = subtitle.try(:squish)
  end
end
