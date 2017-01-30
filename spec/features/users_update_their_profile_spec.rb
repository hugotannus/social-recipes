require 'rails_helper'

feature 'User updates his profile' do
  scenario 'successfully' do
    user = authenticate

    visti edit_user_path user

    fill_in 'Nome', with: 'John Doe Jr.'
    fill_in 'Senha', with: 'novasenha'
    fill_in 'Confirmar senha', with: 'novasenha'

    click_on 'Atualizar dados'

    expect(page).to have_content 'Dados alterados com sucesso!'
    expect(page).to have_content 'John Doe Jr.'
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
