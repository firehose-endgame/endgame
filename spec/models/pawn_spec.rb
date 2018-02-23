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




  describe "is_valid? method" do
    let(:pawn){FactoryBot.create(:pawn, x_coordinate: 3, y_coordinate: 2)}

    it "should allow two spaces vertically on first move" do
      is_valid = pawn.is_valid?(3, 4)
      expect(is_valid).to eq true
    end

    it "should allow one space vertically on other other moves" do
      pawn.move!(3, 3) 
      is_valid = pawn.is_valid?(3, 4)
      expect(is_valid).to eq true
    end

    it "should not allow more than two spaces on other moves" do
      pawn.move!(3, 3)
      is_valid = pawn.reload.is_valid?(3, 5)
      expect(is_valid).to eq false
    end

    it "should allow captures made diagonally one square" do
      pawn.move!(3, 6)
      is_valid = pawn.is_valid?(4, 7)
      expect(is_valid).to eq true
    end

    it "should not allow captures made diagonally multiple squares" do
      is_valid = pawn.is_valid?(8, 7)
      expect(is_valid).to eq false
    end

    it "should not allow captures made vertically" do
      pawn.move!(3, 6)
      is_valid = pawn.is_valid?(3, 7)
      expect(is_valid).to eq false
    end

    it "should not allow captures made horizontally" do
      FactoryBot.create(:queen, x_coordinate: 4, y_coordinate: 2, white: false)
      is_valid = pawn.is_valid?(4, 2)
      expect(is_valid).to eq false
    end

    it "should not allow backward moves" do
      pawn.move!(3, 4)
      is_valid = pawn.is_valid?(3, 3)
      expect(is_valid).to eq false
    end

    it "should allow black pieces to move down" do
      pawn.update(white: false, y_coordinate: 7)
      is_valid = pawn.is_valid?(3, 6)
      expect(is_valid).to eq true
    end

    it "should not allow horizontal moves" do
      pawn.move!(3, 4)
      is_valid = pawn.is_valid?(5, 4)
      expect(is_valid).to eq false
    end

    it "should not allow diagonal moves if not capturing" do
      is_valid = pawn.is_valid?(5, 4)
      expect(is_valid).to eq false
    end
  end
end
