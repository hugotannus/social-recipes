class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # VALID_FB_REGEX = /\A(?:https?:\/\/)?(?:www\.)?facebook\.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[\w\-]*\/)*([\w\-\.]*)\z/i

  has_many :recipes
  has_secure_password

  before_save { self.city  = city.titlecase }
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email, presence: true, uniqueness: true,
                    length: { minimum: 8, maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  # validates :facebook, format: { with: VALID_FB_REGEX }
  validates :city, :password, :password_confirmation, presence: true

end
