require 'rails_helper'

RSpec.describe Rook, type: :model do

	describe "is_valid? method" do
		it "should not allow a diagonal move"
			rook = FactoryBot.create(:rook)
			rook.x_coordinate = 2
			rook.y_coordinate = 2
			is_valid = rook.is_valid?(2,2)
			expect(is_valid).to eq false
		end

	end


end