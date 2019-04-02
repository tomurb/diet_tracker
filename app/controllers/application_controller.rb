class ApplicationController < ActionController::Base
  def current_user
    ::UserPresenter.new(super)
  end

  def after_sign_in_path_for(resource)
    users_show_path
  end
end
