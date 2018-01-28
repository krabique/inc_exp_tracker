# frozen_string_literal: true

class Category < ApplicationRecord
  extend CategoriesHelpers

  belongs_to :user
  has_many :entries, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true, length: { minimum: 1, maximum: 80 }
  validates :group, presence: true, inclusion:
    { in: category_group_options }
end
