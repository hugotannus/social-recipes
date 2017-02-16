RSpec.configure do |config|
  config.after(:each) do
    FactoryGirl.reload if Rails.env.test? || Rails.env.cucumber?
  end
end
