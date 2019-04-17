require 'rails_helper'

RSpec.describe WeightLogsToChartData, type: :service do
  let! (:user) { create(:user) }
  let! (:biometric) { create(:biometric, user: user) }
  let! (:weight_logs) { biometric.weight_logs }
  let! (:weight_log) { weight_logs.last }
  let (:two_weeks_ago ) { 2.weeks.ago.to_date }
  let (:today) { Date.today }
  let(:from) { two_weeks_ago }
  let(:to) { today }
  subject { WeightLogsToChartData.new(weight_logs, from, to) }

  describe '#weight_logs_to_chart' do
    it 'returns array of arrays' do
      expect(subject.call.is_a?(Array)).to be true
      expect(subject.call.first.is_a?(Array)).to be true
    end
    it 'nested arrays consist of date and weight from weight log' do
      nested_array = subject.call.last
      expect(nested_array.first).to eq(weight_log.date)
      expect(nested_array.second).to eq(weight_log.weight)
    end
    context "`from` and `to` dates aren't covered by any of `weight_logs`" do
      before do
        weight_log.update(date: Date.yesterday)
        weight_log.reload
      end
      it 'first and last nested arrays correspond to the values of `from` and `to`' do
        expect(subject.call.first).to eq([two_weeks_ago, nil])
        expect(subject.call.last).to eq([today, nil])
      end
      context 'argument `to` is later than today' do
        let (:to) { Date.tomorrow }
        it 'last nested array corresponds to today' do
          expect(subject.call.last).to eq([today, nil])
        end
      end
    end
  end
end
