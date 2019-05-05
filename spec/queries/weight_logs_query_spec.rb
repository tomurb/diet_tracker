require 'rails_helper'

RSpec.describe WeightLogsQuery, type: :query do
  let(:biometric) { build(:biometric) }
  let(:previous_week_weight_log) do
    create(:weight_log, date: 8.days.ago.to_date, biometric: biometric)
  end
  describe '#last_week' do
    it 'returns object of class WeightLogsQuery' do
      expect(subject.last_week.class).to eq(WeightLogsQuery)
    end
    it 'returns last week weight logs' do
      8.times do |i|
        create(:weight_log, date: i.days.ago.to_date, biometric: biometric)
      end
      expect(subject.last_week.relation.count).to eq(7)
      expect(subject.last_week.relation).not_to include(previous_week_weight_log)
    end
  end

  describe '#between' do
    let(:yesterday) { Date.yesterday }
    let(:today) { Date.today }
    let(:week_ago) { 1.week.ago.to_date }
    it 'returns object of class WeightLogsQuery' do
      expect(subject.between(week_ago, yesterday).class).to eq(WeightLogsQuery)
    end
    it 'returns records with dates between given dates' do
      8.times do |i|
        create(:weight_log, date: i.days.ago.to_date, biometric: biometric)
      end
      expect(subject.between(
        1.week.ago.to_date, Date.yesterday).relation.count).to eq(7)
    end
    it 'throws an error if `from` date is later than `to` date' do
      expect { subject.between(today, yesterday) }.to raise_error WrongDatesOrder
    end
  end
end
