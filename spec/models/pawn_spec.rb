require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "is_valid? method" do
    let(:pawn){FactoryBot.create(:pawn, y_coordinate: 2)}

    it "should allow two spaces vertically on first move" do
      is_valid = pawn.is_valid?(4, 4)
      expect(is_valid).to eq true
    end

    it "should allow one space vertically on other other moves" do
      pawn.update(y_coordinate: 3)  
      is_valid = pawn.is_valid?(4, 4)
      expect(is_valid).to eq true
    end

    it "should not allow more than two spaces on other moves" do
      pawn.update(y_coordinate: 3) 
      is_valid = pawn.reload.is_valid?(4, 5)
      expect(is_valid).to eq false
    end

    it "should allow captures made diagonally one square" do
      pawn.update(y_coordinate: 6)
      is_valid = pawn.is_valid?(5, 7)
      expect(is_valid).to eq true
    end

    it "should not allow captures made diagonally multiple squares" do
      pawn.update(y_coordinate: 5)
      is_valid = pawn.is_valid?(5, 7)
      expect(is_valid).to eq false
    end

    it "should not allow captures made vertically" do
      pawn.update(y_coordinate: 6)
      is_valid = pawn.is_valid?(4, 7)
      expect(is_valid).to eq false
    end

    it "should not allow captures made horizontally" do
      FactoryBot.create(:pawn, x_coordinate: 3, y_coordinate: 4, white: false)
      is_valid = pawn.is_valid?(3, 4)
      expect(is_valid).to eq false
    end

    it "should not allow backward moves" do
      is_valid = pawn.is_valid?(4, 1)
      expect(is_valid).to eq false
    end

    it "should allow black pieces to move down" do
      pawn.update(white: false, y_coordinate: 4)
      is_valid = pawn.is_valid?(4, 3)
      expect(is_valid).to eq true
    end

    it "should not allow horizontal moves" do
      is_valid = pawn.is_valid?(6, 2)
      expect(is_valid).to eq false
    end

    it "should not allow diagonal moves if not capturing" do
      is_valid = pawn.is_valid?(6, 4)
      expect(is_valid).to eq false
    end
  end
end
