require 'rails_helper'

feature 'Visitor visits home' do
  scenario 'successfully' do
    visit root_path
    expect(page).to have_content('Social Recipes')
  end

  scenario 'and sees just last 20 recipes' do
    #setup
    cuisine = create(:cuisine, name: 'condado')
    kind    = create(:kind)
    user    = create(:user)
    # image   = Rack::Test::UploadedFile.new(
    #             File.open(
    #               File.join(Rails.root, '/spec/fixtures/images/sample.png')
    #             )
    #           )

    21.times do |n|
      # travel_to (30 - n).minutes.ago do
        user.recipes.create(
                title: "Receita %02d" % [n+1],
                cuisine: cuisine,
                kind: kind)
      # end
    end

    visit recipes_path

    expect(page).to have_css('.recipe-title', text: "Receita 21")
    expect(page).to have_css('.recipe-title', text: "Receita 20")
    expect(page).to have_css('.recipe-title', text: "Receita 19")
    expect(page).to have_css('.recipe-title', text: "Receita 10")
    expect(page).to have_css('.recipe-title', text: "Receita 02")
    expect(page).to_not have_css('.recipe-title', text: "Receita 01")
  end

  scenario 'and sees the 3 most favorited recipes' do
    #setup
    cuisine = create(:cuisine)
    kind    = create(:kind)
    fav_factor  = [5,1,7,3,2]
    recipes = []

    ## First, lets create tons of users.
    50.times do |n|
      create(:user, name: "User #{n+1}",
              email: "email#{n+1}@example.com")
    end

    ## Some of them has created a recipe...
    5.times do |n|
      recipes[n] = create(:recipe, cusine: cuisine, kind: kind,
              user: User.find_by(id: n+1))

      ## ... and others have favorited some of them
      k = fav_factor[n];

      40.times do |m|
        if (m+1) % k == 0
          user = User.find_by(id: (n+1)+5)
          user.favorites << recipe
        end
      end
    end

    #exercise
    visit root_path

    #expectation
    within('receitas-favoritas') do
      expect(page).to have_content recipes[1].title
      expect(page).to have_content recipes[4].title
      expect(page).to have_content recipes[3].title
      expect(page).to_not have_content recipes[0].title
      expect(page).to_not have_content recipes[2].title
    end
  end
end
