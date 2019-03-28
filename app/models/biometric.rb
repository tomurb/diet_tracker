class Biometric < ApplicationRecord
  belongs_to :user
  validates_presence_of :gender, :age, :height, :weight
end
