require 'rails_helper'

RSpec.describe UserPresenter, type: :presenter do
  let(:user) { create(:user)}
  let!(:biometric) { create(:biometric, user: user, weight: 5) }
  subject { UserPresenter.new(user) }

  let(:weight_log_low) { build(:weight_log, date: 3.days.ago.to_date, weight: 4, biometric_id: biometric.id) }
  let(:weight_log_high) { build(:weight_log, date: 4.days.ago.to_date, weight: 6, biometric_id: biometric.id) }
  let(:weight_log_same) { build(:weight_log, date: 5.days.ago.to_date, weight: 5, biometric_id: biometric.id) }
  let(:weight_log) { build(:weight_log, date: 6.days.ago.to_date, weight: 5, biometric_id: biometric.id) }

  before { WeightLog.delete_all }

  describe '#gaining_days_number' do
    it 'does not take into account days when user was losing weight' do
      weight_log_low.save!
      weight_log.save!
      expect(subject.gaining_days_number(biometric.weight_logs)).to eq 0
    end
    it 'does not take into account days when user kept his weight' do
      weight_log.save!
      weight_log_same.save!
      expect(subject.gaining_days_number(biometric.weight_logs)).to eq 0
    end
    it 'returns a number of days when user was gaining weight' do
      weight_log.save!
      weight_log_high.save!
      expect(subject.gaining_days_number(biometric.weight_logs)).to eq 1
    end
  end

  describe '#losing_days_number' do
    it 'does not take into account days when user was gaining weight' do
      weight_log_high.save!
      weight_log.save!
      expect(subject.losing_days_number(biometric.weight_logs)).to eq 0
    end
    it 'does not take into account days when user kept his weight' do
      weight_log.save!
      weight_log_same.save!
      expect(subject.losing_days_number(biometric.weight_logs)).to eq 0
    end
    it 'returns a number of days when user was losing weight' do
      weight_log.save!
      weight_log_low.save!
      expect(subject.losing_days_number(biometric.weight_logs)).to eq 1
    end
  end
end
