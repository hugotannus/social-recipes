require 'rails_helper'

RSpec.describe Kind, type: :model do
  it 'should be valid' do
    kind = Kind.create()
    expect(kind).not_to be_valid
    expect(kind.errors[:name]).to include("can't be blank")
  end
end
