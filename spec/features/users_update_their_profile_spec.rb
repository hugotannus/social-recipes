require 'rails_helper'

feature 'User updates his profile' do
  scenario 'successfully' do
    user = create(:user)
    authenticate(user)

    within 'header' do
      click_on user.name
      click_on 'Editar perfil'
    end

    fill_in 'Nome', with: 'John Doe Jr.'
    fill_in 'Senha', with: 'novasenha'
    fill_in 'Confirmar senha', with: 'novasenha'

    click_on 'Atualizar dados'

    expect(page).to have_content 'Perfil atualizado com sucesso!'
    expect(page).to have_content 'John Doe Jr.'
  end

  scenario 'and should see an oops message case not' do
    user = create(:user, name: 'Fulano', email: 'fulano@exemplo.com')

    visit edit_user_path user

    expect(page).to have_content 'Oops! Parece que você não está logado...'
  end

  scenario 'and should be redirected to login page case not logged yet' do
    user = create(:user, name: 'Fulano', email: 'fulano@exemplo.com')

    visit edit_user_path user

    expect(page).to have_current_path login_path
  end

  scenario 'just if he is inside you own profile' do
    user = create(:user, name: 'Fulano', email: 'fulano@exemplo.com')
    authenticate(create(:user))

    visit edit_user_path user

    expect(page).to have_content 'O que pensa que está fazendo??? VAZA, maluco!'
    expect(page).to have_current_path root_path
  end

  def authenticate(user)
    visit login_path

    within 'main' do
      click_on 'Entrar'
    end

    fill_in 'Usuário', with: user.email
    fill_in 'Senha',   with: user.password

    within 'main' do
      click_on 'Entrar'
    end
  end
end
