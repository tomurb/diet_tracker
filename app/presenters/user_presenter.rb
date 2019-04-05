class UserPresenter < SimpleDelegator
  delegate :gender, :age, to: :biometric

  def height
    "#{biometric.height} cm"
  end

  def weight
    "#{biometric.weight} kg"
  end

  def bmi
    "%.2f" % Calculators::BmiCalculator.new(biometric).call.round(2)
  end

  def calorie_needs
    "#{"%.2f" % _calorie_needs} kcal"
  end

  def carbohydrate_needs
    array = Calculators::CarbohydratesNeedsCalculator.new(_calorie_needs).call.map do |i|
      "%.2f" % i.round(2)
    end
    min = array.first
    max = array.last
    "#{min} g to #{max} g"
  end

  def protein_needs
    "#{"%.2f" % Calculators::ProteinNeedsCalculator.new(biometric.weight).call.round(2)} g"
  end

  def fat_needs
    "#{"%.2f" % Calculators::FatNeedsCalculator.new(_calorie_needs).call.round(2)} g"
  end

  def presenter_attributes
    self.class.instance_methods(false) - [:presenter_attributes, :weight_logs_to_chart]
  end

  def weight_logs_to_chart
    weight_logs = biometric.weight_logs
    charted = weight_logs.map{|log| [log.date, log.weight]}
    charted.last.first.today? ? nil : charted.push([Date.today, nil])
    charted
  end

  private

  def _calorie_needs
    Calculators::CalorieNeedsCalculator.new(biometric).call
  end
end
