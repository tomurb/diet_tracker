class WeightLogsController < ApplicationController
  def index
    @weight_logs = current_user.biometric.weight_logs.order(:date)
    @from = from
    @to = to
    @charted_weight_logs = WeightLogsToChartData.new(@weight_logs, @from, @to).call
    flash.now[:error] = 'From should not be later than to' if @from > @to
    if params[:commit] == 'CSV'
      csv_data = ::WeightLogsToCsv.new(current_user.biometric.weight_logs).call
      csv_filename = "weight_logs_#{Date.today}.csv"
      send_data csv_data, filename: csv_filename
    end
  end

  def create
    current_user.biometric.weight_logs.create!(weight_log_params)
    redirect_back fallback_location: root_path
  end

  def update
    WeightLog.find(params[:id]).update!(weight_log_params)
    redirect_back fallback_location: root_path
  end

  def destroy
    WeightLog.find(params[:id]).destroy
    redirect_back fallback_location: root_path
  end

  private

  def weight_log_params
    params.require(:weight_log).permit(:date, :weight)
  end

  def to
    params[:to].present? ? params[:to] : Date.today.to_s
  end

  def from
    params[:from].present? ? params[:from] : 2.weeks.ago.to_date.to_s
  end
end
