# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence(:name, 'a') { |n| n + Faker::DrWho.character }
    group            { 'incomes' }
    user

    factory :incomes_category do
      group          { 'incomes' }
    end

    factory :expenses_category do
      group          { 'expenses' }
    end

    factory :invalid_category do
      group          { Faker::DrWho.specie }
    end
  end
end
