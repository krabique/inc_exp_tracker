class Category < ApplicationRecord
  belongs_to :user
  has_many :categories
  
  validates :user, presence: true
  validates :name, presence: true
  validates :type, presence: true
end
