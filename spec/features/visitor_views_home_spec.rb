require 'rails_helper'

feature 'Visitor visits home' do
  scenario 'successfully' do
    visit root_path
    expect(page).to have_content('Social Recipes')
  end

  scenario 'and sees just last 20 recipes' do
    # setup
    Recipe.delete_all
    cuisine = create(:cuisine, name: 'condado')
    kind    = create(:kind)
    user    = create(:user)

    create_list(:recipe, 21, user: user, cuisine: cuisine, kind: kind)

    visit recipes_path

    within ('#ultimas-receitas') do
      expect(page).to have_css('.recipe-title', text: 'Receita 21')
      expect(page).to have_css('.recipe-title', text: 'Receita 20')
      expect(page).to have_css('.recipe-title', text: 'Receita 19')
      expect(page).to have_css('.recipe-title', text: 'Receita 10')
      expect(page).to have_css('.recipe-title', text: 'Receita 02')
      expect(page).to_not have_css('.recipe-title', text: 'Receita 01')
    end
  end

  scenario 'and sees the 3 most favorited recipes' do
    # setup
    cuisine = create(:cuisine)
    kind = create(:kind)
    fav_factor = [5, 1, 7, 3, 2, 2, 8, 4, 9, 8]
    recipes = []

    ## First, lets create tons of users.
    50.times do |n|
      create(:user, name: "User #{n + 1}",
                    email: "email#{n + 1}@example.com")
    end

    ## Some of them has created a recipe...
    10.times do |n|
      recipes[n] = create(:recipe, title: "Recipe #{n + 1}",
                                   cuisine: cuisine, kind: kind,
                                   user: User.find_by(id: n + 1))

      ## ... and others have favorited some of them
      k = fav_factor[n]

      40.times do |m|
        next if (m % k).positive?
        user = User.find_by(id: (m + 1) + 10)
        FavoritedRecipe.create(favorite_id: recipes[n].id,
                               follower_id: user.id)
      end
    end

    # exercise
    visit recipes_path

    # expectation
    within('#receitas-favoritas') do
      expect(page).to have_content recipes[1].title
      expect(page).to have_content recipes[4].title
      expect(page).to have_content recipes[3].title
      expect(page).to have_content recipes[5].title
      expect(page).to have_content recipes[7].title
      expect(page).to_not have_content recipes[0].title
      expect(page).to_not have_content recipes[2].title
      expect(page).to_not have_content recipes[6].title
      expect(page).to_not have_content recipes[8].title
      expect(page).to_not have_content recipes[9].title
    end
  end
end
