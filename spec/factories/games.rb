FactoryBot.define do
  factory :game do
    name "Test"
    association :user
  end
end

