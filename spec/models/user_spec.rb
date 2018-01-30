# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_confirmation_of :password }
  end

  context 'associations' do
    it { should have_many(:entries).dependent(:destroy) }
    it { should have_many(:categories).dependent(:destroy) }
  end
end
