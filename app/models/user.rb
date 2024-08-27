class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

  has_many :reviews

  validates :nickname, presence: true

  before_validation :normalize_fields

  private

  def normalize_fields
    self.nickname = nickname.try(:squish)
  end
end
