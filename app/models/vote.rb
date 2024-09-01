class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :review

  enum :vote_type, { like: 0, dislike: 1 }, prefix: :vote, validate: true

  validates :user_id, uniqueness: { scope: :review_id }
  validate :user_cannot_vote_on_own_review

  private

  def user_cannot_vote_on_own_review
    return if user.blank? || review.blank?

    if user_id == review.user_id
      errors.add(:user_id, "cannot vote on your own review")
    end
  end
end
