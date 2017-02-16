require 'rails_helper'

feature 'User views recipes by cuisine' do
  scenario 'successfully' do
    cuisine = create(:cuisine)
    recipe_a = create(:recipe, cuisine: cuisine)
    recipe_b = create(:recipe, cuisine: cuisine,
                               kind: recipe_a.kind,
                               user: recipe_a.user)
    visit recipes_path

    click_on cuisine.name

    expect(page).to have_css('h2', text: cuisine.name.downcase)
    expect(page).to have_content(recipe_a.title)
    expect(page).to have_content(recipe_b.title)
  end

  scenario 'and view only the recipes from current cuisine' do
    cuisine_1 = create(:cuisine)
    cuisine_2 = create(:cuisine, name: 'italiana')

    recipe_a = create(:recipe,
                      title: 'Receita A',
                      cuisine: cuisine_1)
    recipe_b = create(:recipe, cuisine: cuisine_2,
                               kind: recipe_a.kind,
                               user: recipe_a.user)

    visit recipes_path
    click_on cuisine_2.name

    within('#site-content') do
      expect(page).to have_css('h2', text: cuisine_2.name)
      expect(page).to have_content recipe_b.title
      expect(page).to_not have_content recipe_a.title
      expect(page).not_to have_content cuisine_1.name
    end

  end

  scenario 'view a friendly empty message' do
    cuisine = Cuisine.create(name: 'francesa')

    visit recipes_path
    click_on cuisine.name

    expect(page).to have_content "Ainda não foi adicionada nenhuma receita para a cozinha #{cuisine.name}."
  end

end
