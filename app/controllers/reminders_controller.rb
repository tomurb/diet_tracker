class RemindersController < ApplicationController
  def create
    current_user.create_reminder!
    redirect_back fallback_location: root_path
  end

  def destroy
    current_user.reminder.destroy
    redirect_back fallback_location: root_path
  end
end
