require 'rails_helper'

RSpec.describe Piece, type: :model do
	describe "is_obstructed? method" do
    it "should check if the move is a straight line" do
    	user = FactoryBot.create(:user)
    	game = FactoryBot.create(:game, user_id: user.id)
      mover = FactoryBot.create(:piece, game_id: game.id)
      invalid_move = mover.is_obstructed?('b', '0')
      expect(invalid_move).to eq true
    end

    it "should check for horizontal obstructions" do
    	user = FactoryBot.create(:user)
    	game = FactoryBot.create(:game, user_id: user.id)
      mover = FactoryBot.create(:piece, game_id: game.id)
      blocker = FactoryBot.create(:piece, x_coordinate: 'b', game_id: game.id)
      obstructed_move = mover.is_obstructed?('a', '4')
      unobstructed_move = mover.is_obstructed?('g', '4')
      expect(obstructed_move).to eq true
      expect(unobstructed_move).to eq false
    end

    it "should check for vertical obstructions" do
    	user = FactoryBot.create(:user)
    	game = FactoryBot.create(:game, user_id: user.id)
      mover = FactoryBot.create(:piece, game_id: game.id)
      blocker = FactoryBot.create(:piece, y_coordinate: '6', game_id: game.id)
      obstructed_move = mover.is_obstructed?('d', '8')
      unobstructed_move = mover.is_obstructed?('d', '2')
      expect(obstructed_move).to eq true
      expect(unobstructed_move).to eq false
    end

    it "should check for diagonal obstructions" do
    	user = FactoryBot.create(:user)
    	game = FactoryBot.create(:game, user_id: user.id)
      mover = FactoryBot.create(:piece, game_id: game.id)
      blocker = FactoryBot.create(:piece, x_coordinate: 'f', y_coordinate: '6', game_id: game.id)
      obstructed_move = mover.is_obstructed?('h', '8')
      unobstructed_move_1 = mover.is_obstructed?('e', '2')
      unobstructed_move_2 = mover.is_obstructed?('b', '2')
      unobstructed_move_3 = mover.is_obstructed?('e', '6')
      expect(obstructed_move).to eq true
      expect(unobstructed_move_1).to eq false
      expect(unobstructed_move_2).to eq false
      expect(unobstructed_move_3).to eq false
    end
  end
end
