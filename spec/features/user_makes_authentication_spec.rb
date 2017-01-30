require 'rails_helper'

feature 'User makes authentication' do
  scenario 'successfully' do
    john = User.create(name: 'John Doe',
                    email: 'john.doe@example.com',
                    password: 'foopswd',
                    password_confirmation: 'foopswd')

    visit login_path

    fill_in 'Usuário', with: john.email
    fill_in 'Senha',   with: john.password

    within 'main' do
      click_on 'Entrar'
    end

    expect(page).to have_content "Seja bem-vind@, #{john.name}!"
    expect(page).to have_current_path user_path(john)
    # expect(page).to have_current_path root_path
    expect(page).to have_content john.name
    expect(page).to have_content john.email
end

scenario 'and should find extra navbar links' do
    john = create(:user)

    visit login_path

    fill_in 'Usuário', with: john.email
    fill_in 'Senha',   with: john.password

    within 'main' do
      click_on 'Entrar'
    end

    within 'header' do
      expect(page).to have_content "Minhas receitas"
      expect(page).to have_content "Cadastrar receitas"
      expect(page).to have_content "Sair"
    end
  end

  scenario 'and should not have link for login on navbar' do
    john = create(:user)

    visit login_path

    fill_in 'Usuário', with: john.email
    fill_in 'Senha',   with: john.password

    within 'main' do
      click_on 'Entrar'
    end

    within 'header' do
      expect(page).to have_no_content "Entrar"
    end
  end
end
