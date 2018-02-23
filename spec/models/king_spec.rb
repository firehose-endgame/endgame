require 'rails_helper'

RSpec.describe King, type: :model do
  describe "is_valid? method" do
    it "should check if king can move 1 space up" do
      mover = FactoryBot.create(:king)
      mover.reload
      is_valid = mover.is_valid?(4, 5)
      expect(is_valid).to eq true
    end
    it "should check if king can move 1 space sideways" do
      mover = FactoryBot.create(:king)
      is_valid = mover.is_valid?(3, 4)
      expect(is_valid).to eq true
    end
    it "should check if king can move 1 space diagonally" do
      game = FactoryBot.create(:game)
      diag_moving_king = game.pieces.find_by(type: 'King', white: true)
      diag_moving_king.x_coordinate = 4
      diag_moving_king.y_coordinate = 4
      is_valid = diag_moving_king.is_valid?(3, 5)
      expect(is_valid).to eq true
    end
    it "should check that king does not move into check" do
      check_test_game = FactoryBot.create(:game)
      check_king = check_test_game.pieces.find_by(type: 'King', white: true)
      check_king.x_coordinate = 4
      check_king.y_coordinate = 4
      check_king.move!(4, 5)
      is_valid = check_king.is_valid?(4, 6)
      expect(is_valid).to eq false
    end

    it "should see castling as a valid move" do
      king = FactoryBot.create(:king, x_coordinate: 5)
      rook = FactoryBot.create(:rook, x_coordinate: 1, game: king.game)
      valid_move = king.is_valid?(3, 4)
      expect(valid_move).to eq true
    end

    it "should stop castling if the rook has been moved" do
      king = FactoryBot.create(:king, x_coordinate: 5)
      rook = FactoryBot.create(:rook, x_coordinate: 1, game: king.game, moved: true)
      invalid_move = king.is_valid?(3, 4)
      expect(invalid_move).to eq false
    end

    it "should stop castling if the king has been moved" do
      king = FactoryBot.create(:king, x_coordinate: 5, moved: true)
      rook = FactoryBot.create(:rook, x_coordinate: 1, game: king.game)
      invalid_move = king.is_valid?(3, 4)
      expect(invalid_move).to eq false
    end

    it "should stop castling if the area is obstructed" do
      king = FactoryBot.create(:king, x_coordinate: 5, moved: true)
      rook = FactoryBot.create(:rook, x_coordinate: 1, game: king.game)
      blocker = FactoryBot.create(:piece, game: king.game)
      invalid_move = king.is_valid?(3, 4)
      expect(invalid_move).to eq false
    end
  end
  <<-DOC
  describe "move_to method" do
    it "should be able to castle to the left" do
      king = FactoryBot.create(:king, x_coordinate: 5)
      rook = FactoryBot.create(:rook, x_coordinate: 1, game: king.game)
      king.move_to(3, 4)
      expect(king.x_coordinate).to eq 3
      expect(rook.x_coordinate).to eq 4
    end

    it "should be able to castle to the right" do
      king = FactoryBot.create(:king, x_coordinate: 5)
      rook = FactoryBot.create(:rook, x_coordinate: 8, game: king.game)
      king.move_to(7, 4)
      expect(king.x_coordinate).to eq 7
      expect(rook.x_coordinate).to eq 6
    end
  end
  DOC
end
