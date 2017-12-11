FactoryGirl.define do
  factory :user do
  	email Faker::Internet.email
  	password "mypassword"
  	password_confirmation "mypassword"
  end
end
