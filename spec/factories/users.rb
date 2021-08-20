FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    family_name           { Gimei.name.last.kanji }
    first_name            { Gimei.name.first.kanji }
    family_name_reading   { Gimei.name.last.katakana }
    first_name_reading    { Gimei.name.first.katakana }
    born                  { Faker::Date.between(from: '1930-01-01', to: '2016-12-31') }
  end
end
