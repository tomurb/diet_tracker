require 'rails_helper'

RSpec.describe WeightLog, type: :model do
  let(:weight) { 50 }
  let!(:biometric) { create(:biometric) }
  let(:biometric_weight_logs) { WeightLog.where(biometric_id: biometric.id) }
  describe '.update_last_or_create' do
    it 'creates new record' do
      allow_any_instance_of(ActiveSupport::TimeWithZone).to receive(:today?).and_return(false)
      expect{ biometric_weight_logs.update_last_or_create(weight) }.to change{ biometric_weight_logs.count }.by 1
    end
    context 'when there is already weight log from today for the user' do
      it 'updates the last weight log' do
        expect(biometric_weight_logs.last.created_at.today?).to be true
        expect{ biometric_weight_logs.update_last_or_create(weight) }.not_to change{ biometric_weight_logs.count }
        expect(biometric_weight_logs.last.weight).to eq weight
      end
    end
  end
end
