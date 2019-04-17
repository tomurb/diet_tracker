class WeightLog < ApplicationRecord
  belongs_to :biometric
  after_initialize :default_attributes
  validates_uniqueness_of :date, scope: :biometric_id
  after_save :update_biometric

  def self.update_last_or_create(weight)
    self.create!(weight: weight, date: Date.today)
  rescue StandardError => e
    self.order(:date).last.update!(weight: weight)
  end

  private

  def default_attributes
    self.date ||= Date.today
  end

  def update_biometric
    self.biometric.update!(weight: self.weight) if latest?
  end

  def latest?
    date > self.class.maximum(:date)
  end
end
