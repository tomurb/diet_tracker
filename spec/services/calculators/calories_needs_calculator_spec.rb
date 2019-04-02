require 'rails_helper'

module Calculators
  RSpec.describe CalorieNeedsCalculator, type: :service do
    let(:biometric) { build(:biometric) }
    it 'differentiates the gender of a person' do
      alternative_biometric = build(:biometric, gender: 'female')
      expect(described_class.new(biometric).call).not_to eq(described_class.new(alternative_biometric).call)
    end
    it 'differentiates the age of a person' do
      alternative_biometric = build(:biometric, age: 16)
      expect(described_class.new(biometric).call).not_to eq(described_class.new(alternative_biometric).call)
    end
    it 'differentiates the weight of a person' do
      alternative_biometric = build(:biometric, weight: 116)
      expect(described_class.new(biometric).call).not_to eq(described_class.new(alternative_biometric).call)
    end
  end
end
