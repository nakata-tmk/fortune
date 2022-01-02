FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.characters(number: 10) }
    word
  end
end