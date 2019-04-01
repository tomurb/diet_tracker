class CalorieNeedsCalculator
  attr_reader :gender, :age, :weight

  def initialize(biometric)
    @gender = biometric.gender
    @age = biometric.age
    @weight = biometric.weight
  end

  def call
    if gender == 'male'
      male_needs
    else
      female_needs
    end
  end

  private

  def male_needs
    case age
    when 0..2
    when 3..9
      22.7 * weight + 495
    when 10..17
      17.5 * weight + 651
    when 18..29
      15.3 * weight + 679
    when 30..60
      8.7 * weight + 829
    else
      13.5 * weight + 487
    end
  end

  def female_needs
    case age
    when 0..2
    when 3..9
      22.5 * weight + 499
    when 10..17
      12.2 * weight + 746
    when 18..29
      14.7 * weight + 496
    when 30..60
      11.6 * weight + 879
    else
      10.5 * weight + 596
    end

  end
end
