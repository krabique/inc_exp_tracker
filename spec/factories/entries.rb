# frozen_string_literal: true

FactoryBot.define do
  factory :entry do
    amount        { Random.rand(1000) }
    comment       { 'abc' }
    user
    category
    date { Time.new }

    factory :invalid_entry do
      amount { 'abc' }
    end
  end
end
