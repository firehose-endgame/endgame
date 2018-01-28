RSpec.describe King, type: :model do
	describe "is_valid? method" do
    it "should check if king can move 1 space up" do
    	user = FactoryBot.create(:user)
    	game = FactoryBot.create(:game, user_id: user.id)
      mover = FactoryBot.create(:king, game_id: game.id)
      valid_move = mover.is_valid?(4, 5)
      expect(valid_move).to eq true
    end
    it "should check if king can move 1 space sideways" do
    	user = FactoryBot.create(:user)
    	game = FactoryBot.create(:game, user_id: user.id)
      mover = FactoryBot.create(:king, game_id: game.id)
      valid_move = mover.is_valid?(3, 4)
      expect(valid_move).to eq true
    end
    it "should check if king can move 1 space diagonally" do
    	user = FactoryBot.create(:user)
    	game = FactoryBot.create(:game, user_id: user.id)
      mover = FactoryBot.create(:king, game_id: game.id)
      valid_move = mover.is_valid?(3, 5)
      expect(valid_move).to eq true
    end
  end
end
