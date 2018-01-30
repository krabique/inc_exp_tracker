# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  include CategoriesHelpers

  context 'validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(80) }
    it { should validate_presence_of :group }
    it { should validate_inclusion_of(:group).in_array(category_group_options) }
  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:entries).dependent(:destroy) }
  end
end
