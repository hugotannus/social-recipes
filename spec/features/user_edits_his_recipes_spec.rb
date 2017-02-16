require 'rails_helper'

feature 'User edits his recipes' do
  scenario 'successfully' do
    user = authenticate
    recipe = create(:recipe,
                    user: user,
                    title: 'Sopa de letrinhas',
                    portions: 3,
                    prep_time: 20)

    visit edit_recipe_path recipe

    fill_in 'Título',           with: 'Sopa de letrinas especial'
    fill_in 'Rendimento',       with: 5
    fill_in 'Tempo de preparo', with: 30

    click_on 'Salvar'

    expect(page).to have_content 'Receita atualizada com sucesso!'
    expect(page).to have_css('h2', text: 'Sopa de letrinas especial')
    expect(page).to have_css('#portions-value', text: '5 pessoas')
    expect(page).to have_css('#preptime-value', text: '30 minutos')
  end

  scenario 'just if it belongs to him' do
    user = create(:user, name: 'Fulano', email: 'fulano@exemplo.com')
    recipe = create(:recipe, user: user)
    vaza_maluco = 'Tá mexendo na receita dos outros??? VAZA, maluco!'

    authenticate
    visit edit_recipe_path recipe

    expect(page).to have_content vaza_maluco
    expect(page).to have_current_path root_path
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
