require 'rails_helper'

feature 'Visitor searches for recipes' do
  scenario 'successfully' do
    #setup
    create(:recipe, title: 'Sopa de letrinhas')

    #exercise
    visit root_path

    fill_in 'Procurar por', with: 'sopa de letrinhas'
    click_on 'buscar'

    #expectations
    expect(page).to have_content (
      "Econtrado(s) 1 resultado(s) para sopa de letrinhas."
    )
  end

  scenario 'and matches all recipes with the same substring' do
    #setup
    user    = create(:user)
    cuisine = create(:cuisine, name: 'brasileira')
    kind    = create(:kind,    name: 'sopas')

    create(:recipe, title: 'Sopa de letrinhas',
      cuisine: cuisine, kind: kind, user: user)
    create(:recipe, title: 'Ensopado de peixe',
      cuisine: cuisine, kind: kind, user: user)
    create(:recipe, title: 'Sopinha de legumes',
      cuisine: cuisine, kind: kind, user: user)

    #exercise
    visit root_path

    fill_in 'Procurar por', with: 'sopa'
    click_on 'buscar'

    #expectations
    expect(page).to have_content (
      "Econtrado(s) 2 resultado(s) para sopa."
    )
    expect(page).to have_content 'Sopa de letrinhas'
    expect(page).to have_content 'Ensopado de peixe'
    expect(page).to_not have_content 'Sopinha de legumes'
  end

  scenario 'and found no matches' do
    #setup
    user    = create(:user)
    cuisine = create(:cuisine, name: 'brasileira')
    kind    = create(:kind,    name: 'sopas')

    create(:recipe, title: 'Sopa de letrinhas',
      cuisine: cuisine, kind: kind, user: user)
    create(:recipe, title: 'Ensopado de peixe',
      cuisine: cuisine, kind: kind, user: user)
    create(:recipe, title: 'Sopinha de legumes',
      cuisine: cuisine, kind: kind, user: user)

    #exercise
    visit root_path

    fill_in 'Procurar por', with: 'soup'
    click_on 'buscar'

    #expectations
    expect(page).to have_content (
      "Não foi econtrado nenhum resultado para soup."
    )
    expect(page).to_not have_content 'Sopa de letrinhas'
    expect(page).to_not have_content 'Ensopado de peixe'
    expect(page).to_not have_content 'Sopinha de legumes'
  end
end
