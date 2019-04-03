require 'rails_helper'

RSpec.describe Biometric, type: :model do
  FactoryBot.use_parent_strategy = false
  let(:biometric) { build(:biometric) }
  describe '.create' do
    it 'calls WeightHistory.update_last_or_create with weight' do
      expect(WeightLog).to receive(:update_last_or_create).with(biometric.weight)
      Biometric.create!(biometric.attributes)
    end
  end

  describe '#update' do
    it 'calls WeightHistory.update_last_or_create with weight' do
      expect(WeightLog).to receive(:update_last_or_create).with(biometric.weight)
      biometric.save!
      biometric.update!(biometric.attributes)
    end
  end
end
