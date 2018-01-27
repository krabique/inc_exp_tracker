class Category < ApplicationRecord
  extend CategoriesHelpers

  belongs_to :user, dependent: :destroy
  has_many :entries

  validates :user, presence: true
  validates :name, presence: true, length: { minimum: 1, maximum: 80 }
  validates :group, presence: true, inclusion:
    { in: category_group_options }
end
