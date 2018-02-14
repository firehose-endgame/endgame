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
  end
end