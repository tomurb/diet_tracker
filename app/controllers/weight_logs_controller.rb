class WeightLogsController < ApplicationController
  def index
    @weight_logs = current_user.biometric.weight_logs.order(:date)
    @from = from
    @to = to
    respond_to do |format|
      format.html { handle_html_index }
      format.csv { handle_csv_index }
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

  def handle_html_index
    @charted_weight_logs = WeightLogsToChartData.new(@weight_logs,
                                                     @from, @to).call
  end

  def handle_csv_index
    csv_filename = "weight_logs_#{Date.today}.csv"
    send_data weight_logs_csv_data, filename: csv_filename
  end

  def wrong_dates_order
    flash[:error] = 'From should not be later than to'
    redirect_back fallback_location: root_path, params: { from: @from, to: @to }
  end

  def weight_logs_csv_data
    query = WeightLogsQuery.new(@weight_logs)
    ::WeightLogsToCsv.new(query.between(@from, @to).relation).call
  end

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
