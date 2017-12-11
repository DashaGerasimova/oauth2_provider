FactoryGirl.define do
  factory :user do
  	email Faker::Internet.email
  	password "mypassword"
  end
end
