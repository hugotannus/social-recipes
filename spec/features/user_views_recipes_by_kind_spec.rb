require 'rails_helper'

feature 'User views recipes by kind' do
  scenario 'successfully' do
    kind = create(:kind)
    recipe_a = create(:recipe, kind: kind)
    recipe_b = create(:recipe, kind: kind,
                               cuisine: recipe_a.cuisine,
                               user: recipe_a.user)
    visit recipes_path

    click_on kind.name

    expect(page).to have_css('h2', text: kind.name.downcase)
    expect(page).to have_content(recipe_a.title)
    expect(page).to have_content(recipe_b.title)
  end

  scenario 'and view only the recipes from current kind' do
    kind_1 = create(:kind)
    kind_2 = create(:kind, name: 'principal')

    recipe_a = create(:recipe,
                      title: 'Receita A',
                      kind: kind_1)
    recipe_b = create(:recipe, kind: kind_2,
                               cuisine: recipe_a.cuisine,
                               user: recipe_a.user)

    visit recipes_path
    click_on kind_2.name

    within('#site-content') do
      expect(page).to have_css('h2', text: kind_2.name)
      expect(page).to have_content recipe_b.title
      expect(page).to_not have_content recipe_a.title
      expect(page).not_to have_content kind_1.name
    end

  end

  scenario 'view a friendly empty message' do
    kind = Kind.create(name: 'sobremesa')

    visit recipes_path
    click_on kind.name

    expect(page).to have_content "Ainda não foi adicionada nenhuma receita de #{kind.name}."
  end

end
