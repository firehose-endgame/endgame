class Queen < Piece

  def is_valid?(new_x, new_y)
    return false if not super
    return is_diagnoal?(new_x, new_y) || is_straight?(new_x, new_y)
  end

  def is_diagnoal?(new_x, new_y)
    return x_coordinate - new_x == y_coordinate - new_y
  end

  def is_straight?(new_x, new_y)
    return x_coordinate == new_x || y_coordinate == new_y
  end
end