class WeightLogsController < ApplicationController
  def index
    if params[:commit] == 'CSV'
      csv_data = ::WeightLogsToCsv.new(current_user.biometric.weight_logs).call
      csv_filename = "weight_logs_#{Date.today}.csv"
      send_data csv_data, filename: csv_filename
    else
      redirect_to users_show_path params: {from: params[:from], to: params[:to]}
    end
  end
end
