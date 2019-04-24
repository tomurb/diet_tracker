require 'rails_helper'

RSpec.describe WeightLogsMaximaAndMinima, type: :service do
  let!(:biometric) { create(:biometric, weight: 40) }
  let(:weight_logs) { WeightLog.all.order(date: :asc) }
  subject { WeightLogsMaximaAndMinima.new(weight_logs) }

  let(:plateau_weight_log) do
    build(
        :weight_log,
        biometric: biometric,
        weight: 40,
        date: Date.yesterday
    )
  end
  let(:lower_weight_log) do
    attrs = { weight: 30, date: Date.yesterday }
    build(:weight_log, plateau_weight_log.attributes.merge(attrs))
  end
  let(:higher_weight_log) do
    attrs = { weight: 50, date: Date.yesterday }
    build(:weight_log, plateau_weight_log.attributes.merge(attrs))
  end

  let(:biometric_array) { [Date.today, biometric.weight] }
  let(:plateau_array) { [plateau_weight_log.date, plateau_weight_log.weight] }
  let(:lower_array) { [lower_weight_log.date, lower_weight_log.weight] }
  let(:higher_array) { [higher_weight_log.date, higher_weight_log.weight] }

  describe '#call' do
    context 'only one weight log' do
      it 'returns an empty array' do
        expect(subject.call).to eq([])
      end
    end

    context 'only two weight logs' do
      context 'weight logs have same weights' do
        before { plateau_weight_log.save }
        it 'returns an empty array' do
          expect(weight_logs.count).to eq(2)
          expect(subject.call).to eq([])
        end
      end

      context 'weight logs have different weights' do
        before { lower_weight_log.save }
        it 'returns array of elements corrensponding to both elements' do
          expect(subject.call).to eq([lower_array, biometric_array])
        end
      end
    end

    let(:earlier_plateau_weight_log) do
      build(
          :weight_log,
          biometric: biometric,
          weight: 40,
          date: 2.days.ago.to_date
      )
    end
    let(:earlier_lower_weight_log) do
      attrs = { weight: 20, date: 2.days.ago.to_date }
      build(:weight_log, plateau_weight_log.attributes.merge(attrs))
    end
    let(:earlier_higher_weight_log) do
      attrs = { weight: 60, date: 2.days.ago.to_date }
      build(:weight_log, plateau_weight_log.attributes.merge(attrs))
    end
    let(:earlier_plateau_array) do
      [earlier_plateau_weight_log.date,
       earlier_plateau_weight_log.weight]
    end
    let(:earlier_lower_array) do
      [earlier_lower_weight_log.date,
       earlier_lower_weight_log.weight]
    end
    let(:earlier_higher_array) do
      [earlier_higher_weight_log.date,
       earlier_higher_weight_log.weight]
    end
    context 'three weight logs' do
      context 'weight growing twice' do
        before do
          earlier_lower_weight_log.save
          lower_weight_log.save
        end
        it 'returned array consists two elements' do
          expect(subject.call.size).to eq(2)
        end
        it 'first nested array corresponds to the oldest' do
          expect(subject.call.first).to eq(earlier_lower_array)
        end
        it 'last nested array corresponds to the latest' do
          expect(subject.call.last).to eq(biometric_array)
        end
      end

      context 'growing then falling weight' do
        before do
          earlier_lower_weight_log.save
          higher_weight_log.save
        end
        it 'returns array of consisting 3 elements' do
          expect(subject.call.size).to eq(3)
        end
        it 'first nested array corresponds to the oldest' do
          expect(subject.call.first).to eq(earlier_lower_array)
        end
        it 'second nested array corresponds to the middle one' do
          expect(subject.call.second).to eq(higher_array)
        end
        it 'last nested array corresponds to the latest' do
          expect(subject.call.last).to eq(biometric_array)
        end
      end

      context 'descending then equal weight' do
        before do
          earlier_higher_weight_log.save
          plateau_weight_log.save
        end
        it 'returns array of consisting 2 elements' do
          expect(subject.call.size).to eq(2)
        end
        it 'first nested array corresponds to the oldest' do
          expect(subject.call.first).to eq(earlier_higher_array)
        end
        it 'last nested array corresponds to the middle one' do
          expect(subject.call.last).to eq(plateau_array)
        end
      end
    end

    context 'five weight logs' do
      let(:even_earlier_plateau_weight_log) do
        build(
            :weight_log,
            biometric: biometric,
            weight: 40,
            date: 3.days.ago.to_date
        )
      end
      let(:even_earlier_lower_weight_log) do
        attrs = { weight: 10, date: 3.days.ago.to_date }
        build(:weight_log, plateau_weight_log.attributes.merge(attrs))
      end
      let(:even_earlier_higher_weight_log) do
        attrs = { weight: 70, date: 3.days.ago.to_date }
        build(:weight_log, plateau_weight_log.attributes.merge(attrs))
      end
      let(:even_earlier_plateau_array) do
        [even_earlier_plateau_weight_log.date,
         even_earlier_plateau_weight_log.weight]
      end
      let(:even_earlier_lower_array) do
        [even_earlier_lower_weight_log.date,
         even_earlier_lower_weight_log.weight]
      end
      let(:even_earlier_higher_array) do
        [even_earlier_higher_weight_log.date,
         even_earlier_higher_weight_log.weight]
      end

      context 'all weigh logs are equal' do
        before do
          even_earlier_plateau_weight_log.save
          earlier_plateau_weight_log.save
          plateau_weight_log.save
        end

        it 'returns none' do
          expect(WeightLog.count).to eq(4)
          expect(subject.call.count).to eq(0)
        end
      end

      context 'only first one is lower and the rest is equal' do
        before do
          even_earlier_lower_weight_log.save
          earlier_plateau_weight_log.save
          plateau_weight_log.save
        end
        it 'returns array corresponding to the first two values' do
          expected = [even_earlier_lower_array, earlier_plateau_array]
          expect(subject.call).to eq(expected)
        end
      end
    end
  end
end
