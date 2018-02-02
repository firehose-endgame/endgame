require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "is_valid? method" do
    

      it "should not allow a user not to move" do
          rook = FactoryBot.create(:rook)
          is_valid = rook.is_valid?(4,4)
          expect(is_valid).to eq false
      end


      it "should not allow a diagonal move" do
          rook = FactoryBot.create(:rook)
          is_valid = rook.is_valid?(2,2)
          expect(is_valid).to eq false
      end

      it "should not allow a move off the board on the x-axis" do
          rook = FactoryBot.create(:rook)
          is_valid = rook.is_valid?(0,4)
          expect(is_valid).to eq false
      end

      it "should not allow a move off the board on the y-axis" do
          rook = FactoryBot.create(:rook)
          is_valid = rook.is_valid?(4,0)
          expect(is_valid).to eq false
      end

      it "should allow a horizontal move" do
          rook = FactoryBot.create(:rook)
          is_valid = rook.is_valid?(8,4)
          expect(is_valid).to eq true
      end

      it "should allow a vertical move" do
          rook = FactoryBot.create(:rook)
          obstructing_piece = Piece.where(:game_id => rook.game_id, :x_coordinate => 4, :y_coordinate => 7)
          obstructing_piece.delete_all
          is_valid = rook.is_valid?(4,8)
          expect(is_valid).to eq true
      end


  end
end