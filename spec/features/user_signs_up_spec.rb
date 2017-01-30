require 'rails_helper'

feature 'User signs up' do
  scenario 'successfully' do
    john = User.new(name: 'John Doe',
                    email: 'john.doe@example.com',
                    password: 'foopswd',
                    password_confirmation: 'foopswd')

    visit signup_path

    fill_in 'Nome',             with: john.name
    fill_in 'E-mail',           with: john.email
    fill_in 'Senha',            with: john.password
    fill_in 'Confirmar senha',  with: john.password_confirmation

    click_on 'Criar conta'

    expect(page).to have_content john.name
    expect(page).to have_content john.email
  end
end
