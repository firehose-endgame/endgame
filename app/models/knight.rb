class Knight < Piece

	def is_valid?(new_x, new_y)
		total_x = new_x - self.x_coordinate
		total_x = total_x.abs
		total_y = new_y - self.y_coordinate
		total_y = total_y.abs
		if total_x == 1 && total_y == 3
			return true
		elsif total_x == 3 && total_y == 1
			return true
		else
			return false
		end
	end

end
