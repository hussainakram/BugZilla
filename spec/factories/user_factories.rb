FactoryBot.define do

  factory :user do
    email "john1122@example.com"
    user_type "developer"
    encrypted_password "password"
  end
end
