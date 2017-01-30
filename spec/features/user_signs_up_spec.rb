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

    visit signup_path

    fill_in 'Nome',             with: john.name
    fill_in 'E-mail',           with: john.email
    fill_in 'Cidade',           with: john.city
    fill_in 'Twitter',          with: john.twitter
    fill_in 'Facebook',         with: john.facebook
    fill_in 'Senha',            with: john.password
    fill_in 'Confirmar senha',  with: john.password_confirmation

    click_on 'Criar conta'

    expect(page).to have_content "Parabéns, #{john.name}! Você acaba de criar sua conta no Social Recipes."
    expect(page).to have_content john.name
    expect(page).to have_content john.city
    expect(page).to have_content john.twitter
    expect(page).to have_content john.facebook
    expect(page).to have_content john.email
  end
end
