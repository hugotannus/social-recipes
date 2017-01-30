class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: {minimum: 8, maximum: 255}
  validates :password, :password_confirmation, presence: true


  before_save { self.email = email.downcase }
end
