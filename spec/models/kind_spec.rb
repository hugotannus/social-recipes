require 'rails_helper'

RSpec.describe Kind, type: :model do
  it 'should be valid' do
    kind = Kind.create()
    expect(kind).not_to be_valid
    expect(kind.errors[:name]).to include("can't be blank")
  end

  it 'should have its name saved in downcase' do
    #setup
    kind = Kind.create( name:'Sobremesas')

    #expectation
    expect(kind.name).to eq('sobremesas')
  end

  it 'should have a unique name' do
    Kind.create(name: "Sobremesas")
    name = "SOBREMESAS"

    kind = Kind.create(name: name)
    expect(kind).not_to be_valid
    expect(kind.errors[:name]).to include("has already been taken")
  end
end
