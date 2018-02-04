class Knight < Piece

	def is_valid?(new_x, new_y)
		return false if off_board?(new_x, new_y)
		distance_x = (new_x - self.x_coordinate).abs
		distance_y = (new_y - self.y_coordinate).abs
		if distance_x == 1 && distance_y == 2 || distance_x == 2 && distance_y == 1
			return true
		else
			return false
		end
	end

end
