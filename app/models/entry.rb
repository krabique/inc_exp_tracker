# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :category

  monetize :amount_cents

  validates :amount_cents, presence: true
  validates :user, presence: true
  validates :category, presence: true
  validates :comment, presence: true

  validate :category_belongs_to_user

  private

  def category_belongs_to_user
    errors.add(:category_id, 'does not belong to this user') unless
      user.categories.include?(category)
  end
end
