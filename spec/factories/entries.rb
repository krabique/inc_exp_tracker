# frozen_string_literal: true

FactoryBot.define do
  factory :entry do
    amount        { 100 }
    comment       { 'abc' }
    user
    category
    date { Time.new }

    factory :invalid_entry do
      amount { 'abc' }
    end
  end
end
