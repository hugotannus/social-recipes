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

    click_on 'Entrar'

    expect(page).to have_content "Seja bem-vind@, #{john.name}!"
    expect(page).to have_current_path user_path(john)
    # expect(page).to have_current_path root_path
    expect(page).to have_content john.name
    expect(page).to have_content john.email
  end
end
