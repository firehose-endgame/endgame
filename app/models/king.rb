class King < Piece

  def is_valid?(new_x, new_y)
    return false unless super 
    return (x_coordinate - new_x).abs <=1 && (y_coordinate - new_y).abs <=1
  end

end
