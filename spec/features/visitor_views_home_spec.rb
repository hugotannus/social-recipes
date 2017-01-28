require 'rails_helper'

feature 'Visitor visits Emprego Ja home page' do
  scenario 'successfully' do
    visit root_path
    expect(page).to have_content('Social Recipes')
  end

  scenario 'and sees all the recipes' do
    #setup
    cuisine = create(:cuisine, name: 'condado')
    recipes = create_list(:recipe, 5, cuisine: cuisine)

    visit root_path

    5.times do |n|
      expect(page).to have_css('.recipe_title', text: recipes[n].title)
    end
  end
end
