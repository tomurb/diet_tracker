module WeightLogsHelper
  def local_maxima_and_minima(time_span, biometric)
    logs = WeightLog.where(date: time_span, biometric: biometric)
    WeightLogsMaximaAndMinima.new(logs).call
  end
end
