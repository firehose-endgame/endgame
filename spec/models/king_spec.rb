RSpec.describe King, type: :model do
	describe "is_valid? method" do
    it "should check if king can move 1 space up" do
      mover = FactoryBot.create(:king)
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
  end
end
