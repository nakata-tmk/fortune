FactoryBot.define do
  factory :word do
    body { Faker::Lorem.characters(number: 30) }
  end
end