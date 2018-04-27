FactoryBot.define do
  factory :user do
    email Faker::Internet.email
    user_type 'manager'
    password 'password'
    encrypted_password 'password'
  end
end
