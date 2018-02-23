require 'rails_helper'

RSpec.describe Piece, type: :model do
	 describe "promotable? method" do
    let(:pawn){FactoryBot.create(:pawn, x_coordinate: 3, y_coordinate: 7)}
      it "should allow white pawn at eighth rank to be promoted" do
        promotable = pawn.promotable?(8)
        expect(promotable).to eq true
      end  
      it "should prevent white pawn below the eighth rank to be promoted" do
        promotable = pawn.promotable?(7)
        expect(promotable).to eq false
      end

    let(:blackpawn){FactoryBot.create(:pawn, x_coordinate: 3, y_coordinate: 7, white: false)}
      it "should allow black pawn at eighth rank to be promoted" do
        promotable = blackpawn.promotable?(1)
        expect(promotable).to eq true
      end 
      it "should prevent pawn below the eighth rank to be promoted" do
        promotable = blackpawn.promotable?(2)
        expect(promotable).to eq false
      end
  end

  describe "promotable_pieces method" do
    let(:pawn){FactoryBot.create(:pawn, x_coordinate: 3, y_coordinate: 8)}
      it "should confirm whether queening is possible" do
        promotable = pawn.promotable_pieces(2,3)
        expect(promotable).to eq ["Queen", "Bishop", "Knight", "Rook"]
      end 
  end


  describe "is_obstructed? method" do
    it "should check if the move is a straight line" do
    	user = FactoryBot.create(:user)
    	game = FactoryBot.create(:game, user_id: user.id)
      mover = FactoryBot.create(:piece, game_id: game.id)
      invalid_move = mover.is_obstructed?(2, 0)
      expect(invalid_move).to eq true
    end

    it "should check for horizontal obstructions" do
    	user = FactoryBot.create(:user)
    	game = FactoryBot.create(:game, user_id: user.id)
      mover = FactoryBot.create(:piece, game_id: game.id)
      blocker = FactoryBot.create(:piece, x_coordinate: 2, game_id: game.id)
      obstructed_move = mover.is_obstructed?(1, 4)
      unobstructed_move = mover.is_obstructed?(7, 4)
      expect(obstructed_move).to eq true
      expect(unobstructed_move).to eq false
    end

    it "should check for vertical obstructions" do
    	user = FactoryBot.create(:user)
    	game = FactoryBot.create(:game, user_id: user.id)
      mover = FactoryBot.create(:piece, game_id: game.id)
      blocker = FactoryBot.create(:piece, y_coordinate: 6, game_id: game.id)
      obstructed_move = mover.is_obstructed?(4, 8)
      unobstructed_move = mover.is_obstructed?(4, 2)
      expect(obstructed_move).to eq true
      expect(unobstructed_move).to eq false
    end

    it "should check for diagonal obstructions" do
    	user = FactoryBot.create(:user)
    	game = FactoryBot.create(:game, user_id: user.id)
      mover = FactoryBot.create(:piece, game_id: game.id)
      blocker = FactoryBot.create(:piece, x_coordinate: 6, y_coordinate: 6, game_id: game.id)
      obstructed_move = mover.is_obstructed?(8, 8)
      unobstructed_move_1 = mover.is_obstructed?(6, 2)
      unobstructed_move_2 = mover.is_obstructed?(2, 2)
      unobstructed_move_3 = mover.is_obstructed?(2, 6)
      expect(obstructed_move).to eq true
      expect(unobstructed_move_1).to eq false
      expect(unobstructed_move_2).to eq false
      expect(unobstructed_move_3).to eq false
    end
  end


	describe "#move_to" do
		let(:game) {
			FactoryBot.create(:game)
		}
		let(:piece) {
			FactoryBot.create(:piece, white: true, x_coordinate: 1, y_coordinate: 1, game: game)
		}
		context "when moving to an empty square" do
			before do
				piece.move_to(3,5)
			end
			it "updates the piece's X position" do
				expect(piece.x_coordinate).to eq(3)
			end

			it "updates the piece's Y position" do
				expect(piece.y_coordinate).to eq(5)
			end
		end

		context "when the square is occupied with opponent piece" do
			let(:opponent_piece) {
				FactoryBot.create(:piece, white: false, x_coordinate: 3, y_coordinate: 5, game: game)
			}
			before do
				opponent_piece
				piece.move_to(3,5)
			end
			it "updates the piece's X position" do
				expect(piece.x_coordinate).to eq(3)
			end

			it "updates the piece's Y position" do
				expect(piece.x_coordinate).to eq(3)
			end
			it "captures the opponent piece" do
				expect(opponent_piece.reload.taken).to eq(true)
			end
		end

		context "when the square is occupied with our own piece" do
			before do
				FactoryBot.create(:piece, white: true, x_coordinate: 3, y_coordinate: 5, game: game)
				piece.move_to(3,5)
			end
			it "does NOT update the piece's X position" do
				expect(piece.x_coordinate).not_to eq(3)
			end

			it "does NOT update piece's Y position" do
				expect(piece.x_coordinate).not_to eq(3)
			end
		end
	end
end
