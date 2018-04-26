FactoryBot.define do
  factory :bug do
    title Faker::Science.element
    description Faker::Lorem.sentences
    deadline Faker::Date.between_except(1.year.ago, 1.year.from_now, Date.today)
    bug_type "feature"
    status "Started"
    project
  end
end
