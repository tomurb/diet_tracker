class Biometric < ApplicationRecord
  belongs_to :user
  has_many :weight_logs
  after_commit :log_weight_history
  validates_presence_of :gender, :age, :height, :weight
  enum gender: [:male, :female]

  def log_weight_history
    weight_logs.update_last_or_create(weight)
  end
end
