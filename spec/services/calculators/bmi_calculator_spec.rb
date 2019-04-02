require 'rails_helper'

module Calculators
  RSpec.describe BmiCalculator, type: :service do
    let(:biometric) { build(:biometric) }
    it 'calculates bmi with formula `weight/height^2`' do
      result = biometric.weight.to_f / (biometric.height.to_f / 100) ** 2
      expect(described_class.new(biometric).call).to eq(result)
    end
  end
end
