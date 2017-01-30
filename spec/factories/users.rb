FactoryGirl.define do
  factory :user do
    name "John Doe"
    email "john.doe@example.com"
    password "foopswd"
    password_confirmation "foopswd"
  end
end
