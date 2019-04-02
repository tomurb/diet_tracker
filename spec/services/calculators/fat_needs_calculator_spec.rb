module Calculators
  RSpec.describe FatNeedsCalculator, type: :service do
    let(:calorie_needs) { 2000 }
    subject { FatNeedsCalculator.new(calorie_needs).call}

    it 'usees formula of 30% of daily calorie needs / 9' do
      expect(subject).to eq(calorie_needs * 0.3 / 9)
    end
  end
end
