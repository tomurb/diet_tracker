class WeightLogsQuery
  attr_reader :relation

  def initialize(relation = WeightLog.all)
    @relation = relation
  end

  def last_week
    self.class.new(
      @relation.where('date > :seven_days_ago', seven_days_ago: 7.days.ago.to_date)
    )
  end

  def between(from, to)

    self.class.new(
      @relation.where(date: from..to)
    )
  end
end
