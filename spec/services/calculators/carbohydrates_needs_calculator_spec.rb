module Calculators
  RSpec.describe CarbohydratesNeedsCalculator, type: :service do
    let(:calorie_needs) { 2500 }
    subject { described_class.new(calorie_needs).call }

    describe '#call' do
      it 'first value in array is equal to 45% of total calorie needs' do
        expect(subject.first).to eq(calorie_needs * 0.05 / 4)
      end
      it 'second value in array is equal to 65% of total calorie needs' do
        expect(subject.second).to eq(calorie_needs * 0.1 / 4)
      end
    end
  end
end
