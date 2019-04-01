class UserPresenter < SimpleDelegator
  delegate :gender, :age, to: :biometric

  def height
    "#{biometric.height} cm"
  end

  def weight
    "#{biometric.weight} kg"
  end

  def bmi
    "%.2f" % BmiCalculator.new(biometric).call.round(2)
  end

  def calorie_needs
    "#{CalorieNeedsCalculator.new(biometric).call} kcal"
  end

  def presenter_attributes
    %i(gender age height weight bmi calorie_needs)
  end
end
