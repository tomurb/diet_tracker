module Calculators
  class FatNeedsCalculator
    def initialize(calorie_needs)
      @calorie_needs = calorie_needs
    end

    def call
      @calorie_needs * 0.3 / 9
    end
  end
end
