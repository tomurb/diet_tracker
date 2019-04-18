require 'rails_helper'

RSpec.describe UsersQuery, type: :query do
  let(:biometric) { build(:biometric) }
  let(:reminder) { build(:reminder) }
  let(:user) { create(:user) }
  let(:user_with_reminder) { create(:user, reminder: reminder) }
  let(:user_with_biometric) { create(:user, biometric: biometric) }

  shared_examples 'returns object of class UsersQuery' do
  end
  describe '#to_be_reminded' do
    it 'returns object of class UsersQuery' do
      expect(UsersQuery.new.to_be_reminded.class).to eq(UsersQuery)
    end
    it 'returns relation of users only with set reminder' do
      expect(UsersQuery.new.to_be_reminded.relation).to include(user_with_reminder)
      expect(UsersQuery.new.to_be_reminded.relation).not_to include(user)
    end
  end

  describe '#out_of_date_biometric' do
    it 'returns object of class UsersQuery' do
      expect(UsersQuery.new.out_of_date_biometric.class).to eq(UsersQuery)
    end
    it 'returns relation of users only with biometric updated earlier than today' do
      user_with_biometric.biometric.update(updated_at: 1.days.ago)
      expect(UsersQuery.new.out_of_date_biometric.relation).to include(user_with_biometric)
      expect(UsersQuery.new.out_of_date_biometric.relation).not_to include(user)
    end
  end
end
