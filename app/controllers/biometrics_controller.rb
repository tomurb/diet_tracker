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

  def edit
    @biometric = current_user.biometric || Biometric.new
  end

  def update
    if current_user.biometric.update(biometrics_params)
      redirect_to users_show_path
    end
  end

  private

  def biometrics_params
    params.require(:biometric).permit(:gender, :age, :height, :weight)
  end
end
