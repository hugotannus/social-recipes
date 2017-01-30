require 'rails_helper'
require 'carrierwave_helper'

feature 'User sends a new recipe' do
  scenario 'successfully' do
    #setup
    cuisine = Cuisine.create(name: 'brasileira')
    kind    = Kind.create(name: 'sobremesas')
    image   = Rack::Test::UploadedFile.new(
                File.open(
                  File.join(Rails.root, '/spec/fixtures/images/sample.png')
                )
              )

    recipe = Recipe.new( title: 'pudim',
                          cuisine: cuisine,
                          kind: kind,
                          portions: 6,
                          prep_time: 20,
                          difficulty: 'fácil',
                          ingredients: Faker::Food.ingredient,
                          directions: Faker::Lorem.paragraph(2),
                          picture: image
                        )

      #exercise
      visit new_recipe_path

      fill_in 'Título',           with: recipe.title
      select  cuisine.name,       from: 'Cozinha'
      select  kind.name,          from: 'Tipo de receita'
      fill_in 'Rendimento',       with: recipe.portions
      fill_in 'Tempo de preparo', with: recipe.prep_time
      select  recipe.difficulty,  from: 'Dificuldade'
      fill_in 'Ingredientes',     with: recipe.ingredients
      fill_in 'Modo de preparo',  with: recipe.directions
      attach_file 'Foto', "#{Rails.root}/spec/fixtures/images/sample.png"

      click_on 'Criar Receita'

      #expectations
      expect(page).to have_css('h1', text: recipe.title)
      expect(page).to have_content recipe.cuisine.name
      expect(page).to have_content recipe.kind.name
      expect(page).to have_content recipe.difficulty
      expect(page).to have_content "#{recipe.prep_time} minutos"
      expect(page).to have_content recipe.ingredients
      expect(page).to have_content recipe.directions
      expect(page).to have_xpath("//img[contains(@src,'#{File.basename(recipe.picture.url)}')]")
  end

  scenario 'and should fill all fields' do
    visit new_recipe_path

    click_on 'Criar Receita'

    expect(page).to have_content 'Não foi possível criar a receita.'
  end
end
