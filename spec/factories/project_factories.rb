FactoryBot.define do

  factory :project do
    name Faker::Name.title
    description Faker::Lorem.sentence
  end
end
