require "rails_helper"

RSpec.describe User, type: :model do
  it 'should be valid' do
    user = User.create()
    expect(user).not_to be_valid
    expect(user.errors[:name]).to include("can't be blank")
    expect(user.errors[:email]).to include("can't be blank")
    expect(user.errors[:city]).to include("can't be blank")
    expect(user.errors[:password]).to include("can't be blank")
    expect(user.errors[:password_confirmation]).to include("can't be blank")
  end

  it 'should save email address in downcase' do
    #setup
    user = User.create(name: 'John Doe',
                    email: 'John.Doe@example.com',
                    city: 'São Paulo',
                    password: 'foopswd',
                    password_confirmation: 'foopswd')

    #expectation
    expect(user.email).to eq('john.doe@example.com')
  end

  it 'should have a unique email address' do
    User.create(name: 'John Doe',
                    email: 'john.doe@example.com',
                    city: 'São Paulo',
                    password: 'foopswd',
                    password_confirmation: 'foopswd')

    peter = User.create(name: 'Peter',
                    email: 'John.Doe@example.com',
                    city: 'São Paulo',
                    password: 'foopswd',
                    password_confirmation: 'foopswd')


    expect(peter).not_to be_valid
    expect(peter.errors[:email]).to include("has already been taken")
  end

  it 'should have city name in Title Case' do
    user = User.create(name: 'John Doe',
                    email: 'John.Doe@example.com',
                    city: 'São paulo',
                    password: 'foopswd',
                    password_confirmation: 'foopswd')

    #expectation
    expect(user.city).to eq('São Paulo',)
  end

  it 'should match password and password confirmation' do
    user = User.create( name: 'John Doe',
              email: 'john.doe@example.com',
              city: 'São Paulo',
              password: 'foopswd',
              password_confirmation: 'foopswd')

    expect(user.authenticate('foo')).to be false
    expect(user.authenticate('foopswd')).to be user
  end

  it 'name shoud not be too short' do
    user = User.create( name: 'J',
              email: 'john.doe@example.com',
              city: 'São Paulo',
              password: 'foopswd',
              password_confirmation: 'foopswd')

    expect(user).not_to be_valid
    expect(user.errors[:name][0]).to include("is too short")
  end

  it 'name shoud not be too long' do
    user = User.create( name: 'J'*51,
              email: 'john.doe@example.com',
              city: 'São paulo',
              password: 'foopswd',
              password_confirmation: 'foopswd')

    expect(user).not_to be_valid
    expect(user.errors[:name][0]).to include("is too long")
  end

  it 'email shoud not be too short' do
    user = User.create( name: 'John Doe',
              email: 'j@ex.us',
              city: 'São Paulo',
              password: 'foopswd',
              password_confirmation: 'foopswd')

    expect(user).not_to be_valid
    expect(user.errors[:email][0]).to include("is too short")
  end

  it 'email shoud not be too long' do
    user = User.create( name: 'J'*51,
              email: 'j' * 255 + '@example.com',
              city: 'São Paulo',
              password: 'foopswd',
              password_confirmation: 'foopswd')

    expect(user).not_to be_valid
    expect(user.errors[:email][0]).to include("is too long")
  end

  it 'email shoud have a valid format' do
    user = User.create( name: 'J'*51,
              email: 'john.doe@example',
              city: 'São Paulo',
              password: 'foopswd',
              password_confirmation: 'foopswd')

    expect(user).not_to be_valid
    expect(user.errors[:email][0]).to include("is invalid")
  end

  # it 'facebook link shoud have a valid format' do
  #   user = User.create( name: 'John Doe',
  #                       email: 'john.doe@example.com',
  #                       city: 'São Paulo',
  #                       password: 'foopswd',
  #                       password_confirmation: 'foopswd',
  #                       facebook: 'my_pageid')
  #
  #   expect(user).not_to be_valid
  #   expect(user.errors[:facebook][0]).to include("is invalid")
  # end

  # it 'twitter link shoud have a valid format' do
  #   user = User.create(name: 'John Doe',
  #                      email: 'john.doe@example.com',
  #                      city: 'São Paulo',
  #                      password: 'foopswd',
  #                      password_confirmation: 'foopswd')
  #
  #   expect(user).not_to be_valid
  #   expect(user.errors[:email][0]).to include("is invalid")
  # end

end
