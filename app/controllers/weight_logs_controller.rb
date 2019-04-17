class WeightLogsController < ApplicationController
  def index
    weight_logs = current_user.biometric.weight_logs
    @from = from
    @to = to
    @charted_weight_logs = WeightLogsToChartData.new(weight_logs, @from, @to).call
    flash.now[:error] = 'From should not be later than to' if @from > @to
    if params[:commit] == 'CSV'
      csv_data = ::WeightLogsToCsv.new(current_user.biometric.weight_logs).call
      csv_filename = "weight_logs_#{Date.today}.csv"
      send_data csv_data, filename: csv_filename
    end
  end

  private

  def to
    params[:to].present? ? params[:to] : Date.today.to_s
  end

  def from
    params[:from].present? ? params[:from] : 2.weeks.ago.to_date.to_s
  end
end
