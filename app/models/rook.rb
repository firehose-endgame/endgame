class Rook < Piece

    def is_valid?(new_x, new_y)
    	return false unless super
    	vertical_move(new_x) || horizontal_move(new_y)
    end

    def vertical_move(new_x)
    	return new_x == self.x_coordinate
    end

    def horizontal_move(new_y)
    	return new_y == self.y_coordinate
    end

end
