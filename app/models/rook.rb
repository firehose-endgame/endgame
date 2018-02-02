class Rook < Piece

    def is_valid?(new_x, new_y)
    	return false unless super
    	(new_x == self.x_coordinate || new_y == self.y_coordinate)? true : false
    end

end
