module Calculators
  class ProteinNeedsCalculator
    def initialize(weight)
      @weight = weight
    end

    def call
      @weight * 0.8
    end
  end
end
