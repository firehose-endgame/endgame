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
  end
end