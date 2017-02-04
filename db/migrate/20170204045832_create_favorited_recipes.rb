class CreateFavoritedRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :favorited_recipes do |t|
      t.integer :follower_id
      t.integer :favorite_id

      t.timestamps
    end
    add_index :favorited_recipes, :follower_id
    add_index :favorited_recipes, :favorite_id
    add_index :favorited_recipes, [:follower_id, :favorite_id], unique: true

  end
end
