FactoryBot.define do
  factory :order_address do
    token         { Faker::Lorem.characters }
    postal_code   { Faker::Number.number(digits: 7).to_s.insert(3, '-') }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city          { Faker::Address.city }
    house_number  { Faker::Address.building_number }
    building_name { Faker::Lorem.word }
    phone_number  { Faker::Number.number(digits: 10) }
  end
end
