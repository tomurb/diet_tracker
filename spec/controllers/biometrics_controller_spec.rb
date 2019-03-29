require 'rails_helper'

RSpec.describe BiometricsController, type: :controller do

  describe "GET #edit" do
    let!(:biometric) { create(:biometric) }

    it "returns http success" do
      subject.sign_in biometric.user
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

end
