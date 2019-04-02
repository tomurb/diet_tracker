module Calculators
  class BmiCalculator
    attr_reader :height, :weight

    def initialize(biometric)
      @height = biometric.height
      @weight = biometric.weight
    end

    def call
      weight.to_f / (height.to_f/100)**2
    end
  end
end
