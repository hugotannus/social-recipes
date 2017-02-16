class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password
  has_many :recipes

  has_many :favorited_recipes, foreign_key: 'follower_id'
  has_many :favorites, through: :favorited_recipes

  before_save { self.city  = city.titlecase unless city.nil? }
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :password, :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true,
                    length: { minimum: 8, maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

  def favorited?(recipe)
    !favorites.find_by(id: recipe).nil?
  end
end
