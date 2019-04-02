module Calculators
  class CarbohydratesNeedsCalculator
    attr_reader :calorie_needs

    def initialize(calorie_needs)
      @calorie_needs = calorie_needs
    end

    def call
      [calorie_needs * 0.05 / 4, calorie_needs * 0.1 / 4]
    end
  end
end
