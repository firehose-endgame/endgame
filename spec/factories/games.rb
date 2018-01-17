FactoryBot.define do
  factory :game do
    user_id 1
    opponent_id nil
    current_turn_player_id nil
    winning_player_id nil
  end
end
