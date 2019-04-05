class WeightLog < ApplicationRecord
  belongs_to :biometric
  after_initialize :default_attributes

  def self.update_last_or_create(weight)
    return self.last.update!(weight: weight) if self.last&.date&.today?
    self.create(weight: weight)
  end

  private

  def default_attributes
    self.date ||= Date.today
  end
end
