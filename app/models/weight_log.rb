class WeightLog < ApplicationRecord
  belongs_to :biometric

  def self.update_last_or_create(weight)
    return self.last.update!(weight: weight) if self.last&.created_at&.today?
    self.create(weight: weight)
  end
end
