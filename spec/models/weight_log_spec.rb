require 'rails_helper'

RSpec.describe WeightLog, type: :model do
  let(:weight) { 50 }
  let(:biometric) { create(:biometric) }
  let(:biometric_weight_logs) { WeightLog.where(biometric_id: biometric.id) }
  let(:date) { Date.new(2018, 03, 01) }
  describe '.update_last_or_create' do
    it 'creates new record' do
      biometric_weight_logs.delete_all
      expect{ biometric_weight_logs.update_last_or_create(weight) }.to change{ biometric_weight_logs.count }.by 1
    end
    context 'when there is already weight log from today for the user' do
      it 'updates the last weight log' do
        expect{ biometric_weight_logs.update_last_or_create(weight) }.not_to change{ biometric_weight_logs.count }
        expect(biometric_weight_logs.last.weight).to eq weight
      end
    end
  end
  describe '.new' do
    context "there's no date attribute given" do
      it 'sets date for today' do
        allow(Date).to receive(:today).and_return(date)
        weight_log = biometric.weight_logs.new
        expect(weight_log.date).to eq date
      end
    end
    context "there's date attribute given" do
      it 'sets date according to the given attribute' do
        weight_log = biometric.weight_logs.new(date: date)
        expect(weight_log.date).to eq date
      end
    end
  end

  describe '#save' do

  end
end
