class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :kind
  belongs_to :user

  enum difficulty: %w(fácil moderada difícil)
  mount_uploader :picture, PictureUploader
  has_many :marks, class_name: 'FavoritedRecipe', foreign_key: 'favorite_id'
  has_many :followers, through: :marks

  validates :title, :difficulty, :ingredients, :directions, presence: true

  def include?(term)
    title.downcase.include?(term.downcase)
  end
end
