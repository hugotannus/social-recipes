FactoryGirl.define do
  factory :user do
    name      "John Doe"
    email     "john.doe@example.com"
    city      "São Paulo"
    facebook  "johndoe_id"
    twitter   "@johndoe" 
    password  "foopswd"
    password_confirmation "foopswd"
  end
end
