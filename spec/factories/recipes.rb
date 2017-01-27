FactoryGirl.define do
  factory :recipe do
    title "MyString"
    portions 1
    prep_time 1
    difficulty 1
    ingredients "MyText"
    directions "MyText"
    cuisine nil
    kind nil
  end
end
