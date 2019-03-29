FactoryBot.define do
  factory :biometric do
    gender { 'male' }
    age    { 25 }
    height { 180 }
    weight { 90 }
    user
  end
end
