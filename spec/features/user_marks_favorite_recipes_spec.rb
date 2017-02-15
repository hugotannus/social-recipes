require 'rails_helper'

feature 'User marks favorite recipe' do
  scenario 'successfully' do
    # setup
    recipe = recipe_from_another_user
    favorites_count = recipe.followers.all.size

    user = authenticate

    # exercise
    visit recipe_path recipe

    click_button 'receita favorita'

    # expectation
    # expect(page).to have_css('favorite_counter', text: "#{favorites_count + 1}")
    expect(page).to have_content "Favorita de #{favorites_count + 1} usuário(s)"

  end

  scenario 'and unmark it back' do
    # setup
    recipe = recipe_from_another_user

    someone_favorites_another_user_recipe recipe
    favorites_count = recipe.followers.all.size

    # exercise
    user = authenticate

    visit recipe_path recipe

    click_button 'receita favorita' # first click to favorite a recipe
    click_button 'receita favorita' # second clcick to unfavorite back

    # expectations
    expect(page).to have_content "Favorita de #{favorites_count} usuário(s)"
  end

  def authenticate
    user = create(:user)

    visit login_path

    within 'main' do
      click_on 'Entrar'
    end

    fill_in 'Usuário', with: user.email
    fill_in 'Senha',   with: user.password

    within 'main' do
      click_on 'Entrar'
    end

    user
  end

  def recipe_from_another_user
    another = create(:user, name: 'Fulano', email:'anoher@example.com')

    recipe = create(:recipe, user: another)
  end

  def someone_favorites_another_user_recipe(recipe)
    #authentication
    third = create(:user, name: 'Beltrano', email:'beltrano@example.com')

    visit login_path

    within 'main' do
      click_on 'Entrar'
    end

    fill_in 'Usuário', with: third.email
    fill_in 'Senha',   with: third.password

    within 'main' do
      click_on 'Entrar'
    end

    #favoriting
    visit recipe_path recipe
    click_button 'receita favorita'
  end
end
