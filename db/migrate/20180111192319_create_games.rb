class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
    	t.integer :user_id
    	t.integer :opponent_id
    	t.integer :current_turn_player_id
    	t.integer :winning_player_id
      t.timestamps
    end
  end
end
