FactoryBot.define do
  factory :piece do
    x_coordinate 4
    y_coordinate 4
    white true
    user_id 1
    taken false
    game
    selected false
    association :game
  end
  factory :king, class: King, parent: :piece do
    type "King"
  end
end
