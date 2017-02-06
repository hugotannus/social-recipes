require 'rails_helper'

feature 'User views recipes of others' do
  scenario 'successfully' do
    # setup
    recipe = recipe_from_another_user
    favorites_count = recipe.followers.all.size

    user = authenticate

    # exercise
    visit recipe_path recipe

    # expectation
    expect(page).to have_css('h2', text: "#{recipe.title}")
    expect(page).to have_content "Enviado por #{recipe.user.name}"
  end

  scenario 'and expect to see favorite button' do
    # setup
    recipe = recipe_from_another_user
    favorites_count = recipe.followers.all.size

    user = authenticate

    # exercise
    visit recipe_path recipe

    # expectation
    expect(page).to have_content "receita favorita"
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

    create(:recipe, user: another)
  end
end
