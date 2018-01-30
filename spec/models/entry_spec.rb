# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Entry, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }
  let(:entry) { create(:entry, category: category, user: user) }
  
  context 'validations' do
    it 'monetizes amount_cents' do
      expect(entry).to monetize(:amount_cents)
    end
    it { expect(entry).to validate_presence_of :amount_cents }
    it { expect(entry.user).to be_truthy }
    it { expect(entry).to validate_presence_of :category }
    it { expect(entry).to validate_length_of(:comment).is_at_most(80) }
    it { expect(entry).to validate_presence_of :date }

    context '#category_belongs_to_user' do
      let(:user_one) { create(:user) }
      let(:user_two) { create(:user) }
      let(:category_one) { create(:category, user: user_one) }
      let(:category_two) { create(:category, user: user_two) }

      it 'does not let the entry to be assigned to a category of a ' \
         'different user' do
        entry = Entry.new(attributes_for(
          :entry,
          user_id: user_one.id,
          category_id: category_two.id
        ))

        entry.valid?

        expect(entry.errors[:category_id].first).to(
          eq 'does not belong to this user'
        )
      end
    end
  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:category) }
  end
end
