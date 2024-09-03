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

  def rating_statistics
    counter = reviews.group(:rating).count
    return if counter.blank?

    total = counter.values.sum
    statistics = { total: total }

    (1..5).each do |rating|
      count = counter[rating] || 0
      percentage = total.zero? ? 0 : ((count.to_f / total) * 100).round
      statistics["rating_#{rating}".to_sym] = { rating: rating, count: count, perc: percentage }
    end

    statistics
  end

  private

  def normalize_fields
    self.title = title.try(:squish)
    self.subtitle = subtitle.try(:squish)
  end
end
