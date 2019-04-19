require 'rails_helper'

RSpec.describe WeightLogsQuery, type: :query do
  let(:biometric) { build(:biometric) }
  let(:previous_week_weight_log) { create(:weight_log, date: 8.days.ago.to_date, biometric: biometric)}
  describe '#last_week' do
    it 'returns object of class WeightLogsQuery' do
      expect(WeightLogsQuery.new.last_week.class).to eq(WeightLogsQuery)
    end
    it 'returns last week weight logs' do
      8.times{|i| create(:weight_log, date: i.days.ago.to_date, biometric: biometric) }
      expect(WeightLogsQuery.new.last_week.relation.count).to eq(7)
      expect(WeightLogsQuery.new.last_week.relation).not_to include(previous_week_weight_log)
    end
  end
end
