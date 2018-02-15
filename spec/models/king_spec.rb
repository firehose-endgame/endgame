require 'rails_helper'

RSpec.describe King, type: :model do
  
	describe "is_valid? method" do
    <<-DOC
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
      mover = FactoryBot.create(:king)
      is_valid = mover.is_valid?(3, 5)
      expect(is_valid).to eq true
    end
    it "should check that king does not move into check" do
      game = FactoryBot.create(:game)
      king = game.pieces.find_by(type: 'King', white: true)
      king.move!(4, 5)
      is_valid = king.is_valid?(4, 6)
      expect(is_valid).to eq false
    end
DOC
    it "should see castling as a valid move" do
      king = FactoryBot.create(:king, x_coordinate: 5, y_coordinate: 4)
      rook = FactoryBot.create(:rook, x_coordinate: 1, y_coordinate: 4, game: king.game)
      valid_move = king.is_valid?(3, 4)
      expect(valid_move).to eq true
    end

    it "should stop castling if the rook has been moved" do
      king = FactoryBot.create(:king, x_coordinate: 5, y_coordinate: 4)
      rook = FactoryBot.create(:rook, x_coordinate: 1, y_coordinate: 4, game: king.game, moved: true)
      valid_move = king.is_valid?(3, 4)
      expect(valid_move).to eq false
    end

    it "should stop castling if the king has been moved" do
      king = FactoryBot.create(:king, x_coordinate: 5, y_coordinate: 4, moved: true)
      rook = FactoryBot.create(:rook, x_coordinate: 1, y_coordinate: 4, game: king.game)
      valid_move = king.is_valid?(3, 4)
      expect(valid_move).to eq false
    end
  end

  describe "move_to method" do
    it "should be able to castle to the left" do
      king = FactoryBot.create(:king, x_coordinate: 5, y_coordinate: 4)
      rook = FactoryBot.create(:rook, x_coordinate: 1, y_coordinate: 4, game: king.game)
      king.move_to(3, 4)
      byebug
      expect(king.x_coordinate).to eq 3
      expect(rook.x_coordinate).to eq 4
    end

    it "should be able to castle to the right" do
      king = FactoryBot.create(:king, x_coordinate: 5, y_coordinate: 4)
      rook = FactoryBot.create(:rook, x_coordinate: 8, y_coordinate: 4, game: king.game)
      king.move_to(7, 4)
      expect(king.x_coordinate).to eq 7
      expect(rook.x_coordinate).to eq 6
    end
  end
end
