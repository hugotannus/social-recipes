require 'rails_helper'

feature 'Visitor visits home' do
  scenario 'successfully' do
    visit root_path
    expect(page).to have_content('Social Recipes')
  end

  scenario 'and sees all the recipes' do
    #setup
    cuisine = create(:cuisine, name: 'condado')
    kind    = create(:kind)
    recipes = create_list(:recipe, 5,
                            cuisine: cuisine,
                            kind: kind)

    visit root_path

    5.times do |n|
      expect(page).to have_css('.recipe-title', text: recipes[n].title)
    end
  end
end
