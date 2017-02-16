require 'rails_helper'

feature 'User signs up' do
  scenario 'successfully' do
    john = User.new(name: 'John Doe',
                    email: 'john.doe@example.com',
                    city: 'São Paulo',
                    twitter: '@johndoe',
                    facebook: 'johndoe_id',
                    password: 'foopswd',
                    password_confirmation: 'foopswd')
    message = "Parabéns, #{john.name}! Você criou sua conta no Social Recipes."

    visit signup_path

    fill_in 'Nome',             with: john.name
    fill_in 'E-mail',           with: john.email
    fill_in 'Cidade',           with: john.city
    fill_in 'Twitter',          with: john.twitter
    fill_in 'Facebook',         with: john.facebook
    fill_in 'Senha',            with: john.password
    fill_in 'Confirmar senha',  with: john.password_confirmation

    click_on 'Criar conta'

    expect(page).to have_content message
    expect(page).to have_content john.name
    expect(page).to have_content john.city
    expect(page).to have_content john.email
  end

  scenario 'and should have a valid name' do
    john = build(:user, name: 'A')

    visit signup_path

    fill_in 'Nome',             with: john.name
    fill_in 'E-mail',           with: john.email
    fill_in 'Cidade',           with: john.city
    fill_in 'Twitter',          with: john.twitter
    fill_in 'Facebook',         with: john.facebook
    fill_in 'Senha',            with: john.password
    fill_in 'Confirmar senha',  with: john.password_confirmation

    click_on 'Criar conta'

    expect(page).to have_content 'Erro: não foi possível cadastrar usuário.'
  end

  scenario 'and should have a valid email' do
    john = build(:user, email: 'john@example')

    visit signup_path

    fill_in 'Nome',             with: john.name
    fill_in 'E-mail',           with: john.email
    fill_in 'Cidade',           with: john.city
    fill_in 'Twitter',          with: john.twitter
    fill_in 'Facebook',         with: john.facebook
    fill_in 'Senha',            with: john.password
    fill_in 'Confirmar senha',  with: john.password_confirmation

    click_on 'Criar conta'

    expect(page).to have_content 'Erro: não foi possível cadastrar usuário.'
  end

  scenario 'and should have a password' do
    john = build(:user, password: '', password_confirmation: '')

    visit signup_path

    fill_in 'Nome',             with: john.name
    fill_in 'E-mail',           with: john.email
    fill_in 'Cidade',           with: john.city
    fill_in 'Twitter',          with: john.twitter
    fill_in 'Facebook',         with: john.facebook
    fill_in 'Senha',            with: john.password
    fill_in 'Confirmar senha',  with: john.password_confirmation

    click_on 'Criar conta'

    expect(page).to have_content 'Erro: não foi possível cadastrar usuário.'
  end

  scenario 'and should have a valid password' do
    john = build(:user, password: 'john123', password_confirmation: 'john456')

    visit signup_path

    fill_in 'Nome',             with: john.name
    fill_in 'E-mail',           with: john.email
    fill_in 'Cidade',           with: john.city
    fill_in 'Twitter',          with: john.twitter
    fill_in 'Facebook',         with: john.facebook
    fill_in 'Senha',            with: john.password
    fill_in 'Confirmar senha',  with: john.password_confirmation

    click_on 'Criar conta'

    expect(page).to have_content 'Erro: não foi possível cadastrar usuário.'
  end
end
