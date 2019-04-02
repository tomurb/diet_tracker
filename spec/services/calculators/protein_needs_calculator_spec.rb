module Calculators
  RSpec.describe ProteinNeedsCalculator, type: :service do
    let (:weight) { 80 }
    subject { ProteinNeedsCalculator.new(weight).call }
    it 'multiplies the given weight by 0.8' do
      expect(subject).to eq(weight * 0.8)
    end
  end
end
