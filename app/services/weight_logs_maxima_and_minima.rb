class WeightLogsMaximaAndMinima
  attr_reader :result
  attr_accessor :first_item

  def initialize(weight_logs)
    @weight_logs = weight_logs
    @result = []
    @first_item = nil
  end

  def call
    breaker_finder
    result.uniq
  end

  private

  def breaker_finder
    last_comparison = nil
    counter = arrayed_weight_logs.size - 1

    (1..counter).each do |i|
      current = arrayed_weight_logs[i]
      curr_weight = current.second
      previous = arrayed_weight_logs[i-1]
      prev_weight = previous.second
      comparison = prev_weight <=> curr_weight
      next_comparison = curr_weight <=> arrayed_weight_logs[i+1]&.second

      case comparison
      when 1
        result << previous if last_comparison == nil
        result << current if i == counter || next_comparison <= 0
      when -1
        result << previous if last_comparison == nil
        result << current if i == counter || next_comparison >= 0
      end
      last_comparison = comparison
    end
  end

  def arrayed_weight_logs
    @weight_logs.order(:date).pluck(:date, :weight)
  end
end
