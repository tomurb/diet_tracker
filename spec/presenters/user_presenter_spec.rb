require 'rails_helper'

RSpec.describe UserPresenter, type: :presenter do
  let! (:user) { create(:user) }
  let! (:biometric) { create(:biometric, user: user) }
  let! (:weight_log) { biometric.weight_logs.last }
  subject { UserPresenter.new(user) }

  describe '#weight_logs_to_chart' do
    it 'returns array of arrays' do
      expect(subject.weight_logs_to_chart.is_a?(Array)).to be true
      expect(subject.weight_logs_to_chart.first.is_a?(Array)).to be true
    end
    it 'nested arrays consist of date and weight from weight log' do
      nested_array = subject.weight_logs_to_chart.first
      expect(nested_array.first).to eq(weight_log.date)
      expect(nested_array.second).to eq(weight_log.weight)
    end
    context "there's no nested array corresponding to the current day" do
      it 'the last nested array date is today and weight nil' do
        weight_log.update(date: Date.yesterday)
        weight_log.reload
        expect(subject.weight_logs_to_chart.last).to eq([Date.today, nil])
      end
    end
  end
end
