require 'rails_helper'

feature 'Admin creates a new cuisine' do
  scenario 'successfully' do
    #setup
    cuisine = Cuisine.new( name:'Francesa' )

    #exercise
    visit new_cuisine_path

    fill_in 'Nome', with: cuisine.name
    click on 'Criar Cozinha'

    #expectation
    expect(page).to have_content 'Cozinha'
    expect(page).to have_content cuisine.name
  end

  scenario 'and should fill all fields' do
    #exercise
    visit new_cuisine_path
    click on 'Criar Cozinha'

    #expectation
    expect(page).to have_content 'Não foi possível criar a cozinha.'
  end
end
