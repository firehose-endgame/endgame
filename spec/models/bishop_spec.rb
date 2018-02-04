require 'rails_helper'

RSpec.describe Bishop, type: :model do
  describe "is_valid? method" do
    let(:bishop){FactoryBot.create(:bishop)}

    it "should allow a bishop to move diagonally" do
      is_valid = bishop.is_valid?(6, 6)
      expect(is_valid).to eq true
    end

    it "should not allow a bishop to move up and over" do
      is_valid = bishop.is_valid?(5, 6)
      expect(is_valid).to eq false
    end

    it "should not allow a bishop to move outside the board" do
      is_valid = bishop.is_valid?(9, 9)
      expect(is_valid).to eq false
    end

    it "should not allow a bishop to move if it is obstructed" do
      is_valid = bishop.is_valid?(4, 8)
      expect(is_valid).to eq false
    end
  end
end
