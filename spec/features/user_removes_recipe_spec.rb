require 'rails_helper'

feature 'User removes recipe' do
  scenario 'successfully' do
    #setup
    user = authenticate
    recipe = create(:recipe, user: user)

    #exercise
    visit recipe_path(recipe)

    click_on 'apagar'

    #expectation
    expect(page).to have_content "Receita '#{recipe.title}' apagada com sucesso!"
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
end
