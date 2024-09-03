class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :votes, dependent: :destroy

  broadcasts_refreshes_to :book

  validates :title, :description, presence: true
  validates :rating, numericality: { in: 1..5 }

  before_validation :normalize_fields

  default_scope { order(created_at: :desc) }

  [ "like", "dislike" ].each do |type|
    define_method("update_#{type}_counter") do
      update("#{type}_count": votes.send("vote_#{type}").count)
    end
  end

  private

  def normalize_fields
    self.title = title.try(:squish)
  end
end
