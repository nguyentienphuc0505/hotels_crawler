# frozen_string_literal: true

FactoryBot.define do
  factory :supplier do
    source { Faker::Internet.url }
  end
end
