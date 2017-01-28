require "rails_helper"

RSpec.describe Cuisine, type: :model do
  it 'should be valid' do
    cuisine = Cuisine.create()
    expect(cuisine).not_to be_valid
    expect(cuisine.errors[:name]).to include("can't be blank")
  end

  it 'should have its name saved in downcase' do
    #setup
    cuisine = Cuisine.create( name:'Francesa')

    #expectation
    expect(cuisine.name).to eq('francesa')
  end

  it 'should have a unique name' do
    Cuisine.create(name: "Francesa")
    name = "FRANCESA"

    cuisine = Cuisine.create(name: name)
    expect(cuisine).not_to be_valid
    expect(cuisine.errors[:name]).to include("has already been taken")
  end
end
