class UsersController < ApplicationController
  def show
    @from = from
    @to = to
    flash.now[:error] = 'From should not be later than to' if @from > @to
  end

  private

  def to
    params[:to].present? ? params[:to] : Date.today.to_s
  end

  def from
    params[:from].present? ? params[:from] : 2.weeks.ago.to_date.to_s
  end
end
