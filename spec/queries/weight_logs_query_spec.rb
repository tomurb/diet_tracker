require 'rails_helper'

RSpec.describe WeightLogsQuery, type: :query do
  let(:biometric) { build(:biometric) }
  let(:previous_week_weight_log) { create(:weight_log, date: 8.days.ago.to_date, biometric: biometric)}
  describe '#last_week' do
    it 'returns object of class WeightLogsQuery' do
      expect(subject.last_week.class).to eq(WeightLogsQuery)
    end
    it 'returns last week weight logs' do
      8.times{|i| create(:weight_log, date: i.days.ago.to_date, biometric: biometric) }
      expect(subject.last_week.relation.count).to eq(7)
      expect(subject.last_week.relation).not_to include(previous_week_weight_log)
    end
  end

  describe '#between' do
    it 'returns object of class WeightLogsQuery' do
      expect(subject.between(1.week.ago.to_date, Date.yesterday).class).to eq(WeightLogsQuery)
    end
    it 'returns records with dates between given dates' do
      8.times{|i| create(:weight_log, date: i.days.ago.to_date, biometric: biometric) }
      expect(subject.between(1.week.ago.to_date, Date.yesterday).relation.count).to eq(7)
    end
    it 'throws an error if `from` date is later than `to` date' do
      expect { subject.between(Date.today, Date.yesterday) }.to raise_error WrongDatesOrder
    end
  end
end
