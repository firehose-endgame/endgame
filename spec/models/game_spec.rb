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

  describe "game.check?" do
    let(:game){FactoryBot.create(:game)}
    it "should not be in check at start of game" do
      check = game.check?(white=true)
      expect(check).to eq(false)
    end

    it "should not be in check at start of game and piece is black" do
      check = game.check?(white=false)
      expect(check).to eq(false)
    end

    it "should be in check when the white king can be taken" do
      game.pieces.find_by(type: 'Queen', white: false).move!(4, 5)
      game.pieces.find_by(type: 'King', white: true).move!(4, 4)
      check = game.check?(white=true)
      expect(check).to eq(true)
    end

    it "should be in check when the black king can be taken" do
      game.pieces.find_by(type: 'Queen', white: true).move!(4, 4)
      game.pieces.find_by(type: 'King', white: false).move!(4, 5)
      check = game.check?(white=false)
      expect(check).to eq(true)
    end
  end
  describe "game.checkmate" do
      let(:game){FactoryBot.create(:game)}

      it "should be checkmate when the King cannot capture the @threatening_piece, move_out_of_check, or the @threatening_piece cannot be obstructed" do
        game.pieces..each do |piece|
          piece.capture!(piece)
        end

        game.pieces.find_by(type: 'King', white: true).move!(4, 5)
        game.pieces.find_by(type: 'Rook', white: false).move!(3, 4)
        game.pieces.find_by(type: 'Rook', white: false).move!(5, 4)
        game.pieces.find_by(type: 'Queen', white: false).move!(4, 4)
        checkmate = game.checkmate(white=true)
        check = game.check?(white=true)
        expect(check).to eq(true)
        expect(checkmate).to eq(true)
      end
      it "should not be checkmate when the King can capture the @threatening_piece" do
        game.pieces.find_by(type: 'Queen', white: false).move!(4, 5)
        game.pieces.find_by(type: 'King', white: true).move!(4, 4)
        checkmate = game.checkmate(white=true)
        check = game.check?(white=true)
        expect(check).to eq(true)
        expect(checkmate).to eq(false)
      end
      it "should not be checkmate when the King can move out of check" do
        game.pieces.find_by(type: 'Rook', white: false).move!(4, 5)
        game.pieces.find_by(type: 'King', white: true).move!(4, 3)
        checkmate = game.checkmate(white=true)
        check = game.check?(white=true)
        expect(check).to eq(true)
        expect(checkmate).to eq(false)
      end
      it "should not be in checkmate when @threatening_piece is_obstructable" do
        game.pieces.find_by(type: 'Rook', white: false).move!(3, 5)
        game.pieces.find_by(type: 'Pawn', white: true).move!(5, 4)
        game.pieces.find_by(type: 'King', white: true).move!(6, 5)
        checkmate = game.checkmate(white=true)
        check = game.check?(white=true)
        expect(check).to eq(true)
        expect(checkmate).to eq(false)
      end
    end
  end
