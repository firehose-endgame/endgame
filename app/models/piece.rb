class Piece < ApplicationRecord
	belongs_to :game

	def is_obstructed?(new_x, new_y)

	end
end
