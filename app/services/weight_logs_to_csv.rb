class WeightLogsToCsv
  def initialize(weight_logs)
    @weight_logs = weight_logs
  end

  def call
    attributes = %w(date weight)
    CSV.generate(headers: true) do |csv|
      csv << attributes
      @weight_logs.pluck(:date, :weight).each do |weight_log|
        csv << weight_log
      end
    end
  end
end
