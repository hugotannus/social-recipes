class FavoritedRecipe < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :favorite, class_name: "Recipe"
  validates :follower_id, presence: true
  validates :favorite_id, presence: true
end
