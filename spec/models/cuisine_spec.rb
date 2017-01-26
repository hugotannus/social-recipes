require "rails_helper"

RSpec.describe Cuisine, type: :model do
  it 'should be valid' do
    cuisine = Cuisine.create()
    expect(cuisine).not_to be_valid
    expect(cuisine.errors[:name]).to include("can't be blank")
  end

  # it 'should be unique' do
  #   Cuisine.create(name: "Desenvolvedor")
  #   name = "DESENVOLVEDOR"
  #
  #   cuisine = Cuisine.create(name: name)
  #   expect(cuisine).not_to be_valid
  #   expect(cuisine.errors[:name]).to include("has already been taken")
  # end
end
