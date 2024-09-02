class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

  has_many :reviews
  has_many :votes

  validates :nickname, presence: true

  before_validation :normalize_fields

  def can_vote_review?(review)
    id != review.user_id
  end

  def get_vote_for_review(review)
    review.votes.find { |vote| vote.user_id == id }
  end

  private

  def normalize_fields
    self.nickname = nickname.try(:squish)
  end
end
