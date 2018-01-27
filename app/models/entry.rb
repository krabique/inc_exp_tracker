class Entry < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :category, dependent: :destroy
  
  monetize :amount_cents
  
  validates :amount_cents, presence: true
  validates :user, presence: true
  validates :category, presence: true
end
