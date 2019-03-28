class BiometricsController < ApplicationController
  def create
    biometric = current_user.build_biometric(biometrics_params)
    if biometric.save
      redirect_to biometrics_path
    else
      flash[:error] = biometric.errors.full_messages
      redirect_back fallback_location: root_path
    end
  end

  def show
    @biometric = current_user.biometric
  end

  def edit
    @biometric = current_user.biometric || Biometric.new
  end

  def update
  end

  private

  def biometrics_params
    params.require(:biometric).permit(:gender, :age, :height, :weight)
  end
end
