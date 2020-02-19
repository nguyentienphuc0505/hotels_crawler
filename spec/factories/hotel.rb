# frozen_string_literal: true

FactoryBot.define do
  factory :hotel do
    sequence :hotel_id do |n|
      "#{Faker::Lorem.word}#{n}"
    end
    destination_id { Faker::Number.digit }
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    location do
      {
        city: Faker::Lorem.word,
        lat: 0,
        lng: 0,
        country: 'SG'
      }
    end
    booking_conditions { [Faker::Lorem.sentence, Faker::Lorem.sentence] }
  end
end
