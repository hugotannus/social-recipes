require 'rails_helper'

feature 'User sends a new recipe' do
  scenario 'successfully' do
    #setup
    cuisine = Cuisine.new(name: 'brasileira')
    kind    = Kind.new(name: 'sobremesas')

    recipe = Recipe.new( title: 'pudim',
                          cuisine: cuisine,
                          kind: kind,
                          portions: 6,
                          prep_time: 20,
                          difficulty: 'fácil',
                          ingredients: '- 1 lata de leite condensado\n
                          - 2 latas de leite (use a lata de leite  condensado como medida)\n
                          - 4 ovos\n
                          - 1/2 xícara de açúcar\n
                          - 1/3 xícara de água',
                          directions: '1. Prepare o pudim batendo todos os ingredientes no liquidificador\n
                          2. Prepare a calda colocando água e açúcar em uma forma refratária com buraco no meio, de 24 cm de diâmetro\n
                          3. Leve ao microondas na temperatura máxima por 8 minutos, até caramelizar o açúcar\n
                          4. Retire a forma do microondas e girando-a entre as mãos, faça a calda cobrir as paredes da forma\n
                          5. Deixe esfriar um pouco\n
                          6. Coloque na forma a mistura do liquidificador e cubra parcialmente com filme plástico ou prato\n
                          7. Leve ao microondas na temperatura máxima por 9 a 10 minutos\n
                          8. Retire do microondas e deixe esfriar\n
                          9. Leve à geladeira'
                        )

      #exercise
      visit new_recipe_path

      fill_in 'Título',           with: recipe.title
      select  cuisine.name,       from: 'Cozinha'
      select  kind.name,          from: 'Tipo de Receita'
      fill_in 'Rendimento',       with: recipe.portions
      fill_in 'Tempo de preparo', with: recipe.preparation
      select  recipe.difficulty,  from: 'Dificuldade'
      fill_in 'Ingredientes',     with: recipe.ingredients
      fill_in 'Modo de preparo',  with: recipe.directions

      click_on 'Criar Receita'

      #expectations
      expect(page).to have_css('h1', text: recipe.title)
      expect(page).to have_content recipe.cuisine.name
      expect(page).to have_content recipe.kind.name
      expect(page).to have_content recipe.difficulty
      expect(page).to have_content `#{recipe.preparation} minutos`
  end

  scenario 'and should fill all fields' do
    visit new_job_path

    click_on 'Criar Receita'

    expect(page).to have_content 'Não foi possível criar a receita'
  end
end
