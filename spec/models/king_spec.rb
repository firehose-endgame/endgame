require 'rails_helper'

RSpec.describe King, type: :model do
	describe "is_valid? method" do
    it "should be true when moving 1 space" do
    	user = FactoryBot.create(:user)
    	game = FactoryBot.create(:game, user_id: user.id)
      mover = FactoryBot.create(:king, x_coordinate: 4, y_coordinate: 4, game_id: game.id)
      valid_move = mover.is_valid?(4, 5)
      expect(valid_move).to eq true
    end
  end
end
