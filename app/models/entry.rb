class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :category
  
  monetize :amount_cents
  
  validates :amount_cents, presence: true
  validates :user, presence: true
  validates :category, presence: true
end
