require 'rails_helper'

RSpec.describe UserPresenter, type: :presenter do
  let! (:user) { create(:user) }
  let! (:biometric) { create(:biometric, user: user) }
  let! (:weight_log) { biometric.weight_logs.last }
  let (:today) { Date.today }
  let (:two_weeks_ago ) { 2.weeks.ago.to_date }
  subject { UserPresenter.new(user) }

  describe '#weight_logs_to_chart' do
    it 'returns array of arrays' do
      expect(subject.weight_logs_to_chart(two_weeks_ago, today).is_a?(Array)).to be true
      expect(subject.weight_logs_to_chart(two_weeks_ago, today).first.is_a?(Array)).to be true
    end
    it 'nested arrays consist of date and weight from weight log' do
      nested_array = subject.weight_logs_to_chart(two_weeks_ago, today).last
      expect(nested_array.first).to eq(weight_log.date)
      expect(nested_array.second).to eq(weight_log.weight)
    end
    context "`from` and `to` dates aren't covered by any of `weight_logs`" do
      before do
        weight_log.update(date: Date.yesterday)
        weight_log.reload
      end
      it 'first and last nested arrays correspond to the values of `from` and `to`' do
        expect(subject.weight_logs_to_chart(two_weeks_ago, today).first).to eq([two_weeks_ago, nil])
        expect(subject.weight_logs_to_chart(two_weeks_ago, today).last).to eq([today, nil])
      end
      context 'argument `to` is later than today' do
        let (:tomorrow) { Date.tomorrow }
        it 'last nested array corresponds to today' do
          expect(subject.weight_logs_to_chart(two_weeks_ago, tomorrow).last).to eq([today, nil])
        end
      end
    end
  end
end
