# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :category

  monetize :amount_cents

  validates :amount_cents, presence: true
  validates :user, presence: true
  validates :category, presence: true
  validates :comment, length: { maximum: 80 }
  validates :date, presence: true

  validate :category_belongs_to_user

  paginates_per 5

  private

  def category_belongs_to_user
    if category.nil?
      errors.add(:category_id, 'cannot be blank')
    elsif !user.categories.include?(category)
      errors.add(:category_id, 'does not belong to this user')
    end
  end
end
