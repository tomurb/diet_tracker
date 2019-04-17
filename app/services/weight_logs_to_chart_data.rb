class WeightLogsToChartData

  def initialize(weight_logs, from, to)
    @weight_logs = weight_logs
    @to = [to.to_date, Date.today].min
    @from = from.to_date

  end

  def call
    weight_logs = @weight_logs.where(date: @from..@to)
    charted = weight_logs.pluck(:date, :weight)
    add_empty_on_ends(charted)
  end

  private

  def add_empty_on_ends(charted)
    charted.append([@to, nil]) unless charted.last&.first&.today?
    charted.prepend([@from, nil]) if charted.first.first > @from
    charted
  end
end
