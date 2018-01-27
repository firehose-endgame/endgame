require 'rails_helper'

RSpec.describe Game, type: :model do

	describe "piece_name method" do
		it "should create the correct piece for a given starting position" do
			user = FactoryBot.create(:user)
    	game = FactoryBot.create(:game, user_id: user.id)
			game.piece_name(6, 1).should == "Bishop"
			game.piece_name(5, 8).should == "Queen"
			game.piece_name(2, 2).should == "Pawn"
			game.piece_name(8, 8).should == "Rook"
    end
	end

	describe "populate_game! method" do
		it "should create pieces that belong to a game" do
			user = FactoryBot.create(:user)
    	game = FactoryBot.create(:game, user_id: user.id)
    	piece = Piece.last
			expect(piece.game_id).to eq(game.id)
    end

		it "should create 32 pieces for a game" do
			baseline = Piece.count
			user = FactoryBot.create(:user)
    	game = FactoryBot.create(:game, user_id: user.id)
    	compare = Piece.count
			expect(baseline + 32).to eq(compare)
    end

    it "should create white and black pieces for a game" do
			user = FactoryBot.create(:user)
    	game = FactoryBot.create(:game, user_id: user.id)
    	black_piece = Piece.last
    	white_piece = Piece.offset(17).last
			expect(black_piece.white).to eq(false)
			expect(white_piece.white).to eq(true)
    end

    it "should create white pieces assigned to user creating the game" do
			user = FactoryBot.create(:user)
    	game = FactoryBot.create(:game, user_id: user.id)
    	current_user_piece = Piece.offset(17).last
			expect(current_user_piece.user_id).to eq(user.id)
    end

	end




	
end
