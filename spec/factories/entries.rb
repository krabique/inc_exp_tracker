# frozen_string_literal: true

FactoryBot.define do
  factory :entry do
    amount        { 100 }
    comment       { 'abc' }
    user
    category
    date { Time.new }
  end
end
