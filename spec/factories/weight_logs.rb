FactoryBot.define do
  factory :weight_log do
    biometric { nil }
    weight { 1 }
    sequence(:date, 0) { |d| d.days.ago.to_date }
  end
end
