require 'rails_helper'

feature 'Visitor view all recipes' do
  scenario 'and sees first just last 20 recipes' do
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
end
