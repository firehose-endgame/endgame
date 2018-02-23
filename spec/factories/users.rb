FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "fakeEmail#{n}@gmail.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
  end
end
