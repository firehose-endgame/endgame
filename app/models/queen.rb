class Queen < Piece

  def is_valid?(new_x, new_y)
    return super
    return false unless super
    return is_valid_diagonal?(new_x, new_y) || is_valid_straight?(new_x, new_y)
  end

end