RSpec.describe Knight, type: :model do
	describe "is_valid? method" do
    it "checks for valid moves" do
      mover = FactoryBot.create(:knight)
      valid_move_1 = mover.is_valid?(1, 3)
      valid_move_2 = mover.is_valid?(5, 7)
      expect(valid_move_1).to eq true
      expect(valid_move_2).to eq true
    end
    it "stops invalid moves" do
      mover = FactoryBot.create(:knight)
      invalid_move = mover.is_valid?(4, 3)
      expect(invalid_move).to eq false
    end
  end
end