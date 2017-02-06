require 'rails_helper'

feature 'Admin creates a new kind of food' do
  scenario 'successfully' do
    # setup
    kind = Kind.new( name:'Acompanhamentos' )

    # exercise
    visit new_kind_path

    fill_in 'Nome', with: kind.name
    click_on 'Criar Tipo de Receita'

    # expectation
    within '#site-content' do
      expect(page).to have_content kind.name.downcase
    end
  end

  scenario 'and should fill all fields' do
    # exercise
    visit new_kind_path
    click_on 'Criar Tipo de Receita'

    # expectation
    expect(page).to have_content 'Não foi possível criar o tipo de receita.'
  end
end
