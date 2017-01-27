class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.integer :portions
      t.integer :prep_time
      t.integer :difficulty
      t.text :ingredients
      t.text :directions
      t.references :cuisine, foreign_key: true
      t.references :kind, foreign_key: true

      t.timestamps
    end
  end
end
