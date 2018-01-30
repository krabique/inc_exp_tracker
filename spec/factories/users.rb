# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email             { Faker::Internet.email }
    password          'abcd1234'
  end
end
