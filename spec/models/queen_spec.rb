require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "is_valid? method" do
    let(:queen){FactoryBot.create(:queen)}

    it "should not able to move where another piece is" do
      is_valid = queen.is_valid?(4, 2)
      expect(is_valid).to eq false
    end

    it "should allow a queen to move vertically" do
      is_valid = queen.is_valid?(4, 6)
      expect(is_valid).to eq true
    end

    it "should allow a queen to move horizontally" do
      is_valid = queen.is_valid?(8, 4)
      expect(is_valid).to eq true
    end

    it "should allow a queen to move diagonally" do
      is_valid = queen.is_valid?(6, 6)
      expect(is_valid).to eq true
    end

    it "should not allow a queen to move up and over" do
      is_valid = queen.is_valid?(5, 6)
      expect(is_valid).to eq false
    end

    it "should not allow a queen to move outside the board" do
      is_valid = queen.is_valid?(9, 9)
      expect(is_valid).to eq false
    end

    it "should not allow a queen to move if it is obstructed" do
      is_valid = queen.is_valid?(4, 8)
      expect(is_valid).to eq false
    end
  end
end