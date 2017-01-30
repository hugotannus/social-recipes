require 'rails_helper'

feature 'User makes authentication' do
  scenario 'successfully' do
    john = User.create(name: 'John Doe',
                    email: 'john.doe@example.com',
                    city: 'São Paulo',
                    password: 'foopswd',
                    password_confirmation: 'foopswd')

    visit login_path

    fill_in 'Usuário', with: john.email
    fill_in 'Senha',   with: john.password

    within 'main' do
      click_on 'Entrar'
    end

    within 'header' do
      click_on 'Sair'
    end

    expect(page).to have_content "Até mais, #{john.name}! Volte sempre :-)"
  end

  scenario 'and should return to home' do
    john = User.create(name: 'John Doe',
                    email: 'john.doe@example.com',
                    city: 'São Paulo',
                    password: 'foopswd',
                    password_confirmation: 'foopswd')

    visit login_path

    fill_in 'Usuário', with: john.email
    fill_in 'Senha',   with: john.password

    within 'main' do
      click_on 'Entrar'
    end

    within 'header' do
      click_on 'Sair'
    end

    expect(page).to have_current_path root_path
  end

  scenario 'and should find initial navbar links' do
    john = create(:user)

    visit login_path

    fill_in 'Usuário', with: john.email
    fill_in 'Senha',   with: john.password

    within 'main' do
      click_on 'Entrar'
    end

    within 'header' do
      click_on 'Sair'
    end

    within 'header' do
      expect(page).to have_content "Entrar"
    end
  end

  scenario 'and should not see logged in user links' do
    john = create(:user)

    visit login_path

    fill_in 'Usuário', with: john.email
    fill_in 'Senha',   with: john.password

    within 'main' do
      click_on 'Entrar'
    end

    within 'header' do
      click_on 'Sair'
    end

    within 'header' do
      expect(page).to have_no_content "Minhas receitas"
      expect(page).to have_no_content "Cadastrar receitas"
      expect(page).to have_no_content "Sair"
    end
  end
end
