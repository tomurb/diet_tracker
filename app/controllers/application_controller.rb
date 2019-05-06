class ApplicationController < ActionController::Base

  rescue_from WrongDatesOrder, with: :wrong_dates_order

  def current_user
    ::UserPresenter.new(super)
  end

  def after_sign_in_path_for(resource)
    users_show_path
  end

  private

  def wrong_dates_order
    raise NotImplementedError
  end
end
