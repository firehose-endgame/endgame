FactoryBot.define do
  factory :piece do
    x_coordinate 4
    y_coordinate 4
    white true
    user_id 1
    taken false
    game
    selected false
  end
  factory :king, parent: :piece do
    type "King"
    x_coordinate 4
    y_coordinate 4
  end
end
