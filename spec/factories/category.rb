# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name             { Faker::DrWho.character }
    group            { 'incomes' }
    user
    
    factory :incomes_category do
      group          { 'incomes' }
    end
    
    factory :expenses_category do
      group          { 'expenses' }
    end
  end
end
