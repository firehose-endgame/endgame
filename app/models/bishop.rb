class Bishop < Piece

  def is_valid?(new_x, new_y)
    return false unless super
    return is_valid_diagonal?(new_x, new_y)
  end

end
