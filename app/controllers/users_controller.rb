class UsersController < ApplicationController
  def show
    @biometric = current_user.biometric
    @biometric && @bmi = ::BmiCalculator.new(@biometric).call
  end
end
