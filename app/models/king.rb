class King < Piece

  def is_valid?(new_x, new_y)
    return false unless super
    if !moved && castle_move?(new_x, new_y)
      if x_coordinate - new_x == 2
        return false if is_obstructed?(1 , new_y)
        castle_rook = game.pieces.find_by(x_coordinate: 1, y_coordinate: y_coordinate, moved: false)
        return true unless castle_rook.nil?
      else
        return false if is_obstructed?(8 , new_y)
        castle_rook = game.pieces.find_by(x_coordinate: 8, y_coordinate: y_coordinate, moved: false)
        return true unless castle_rook.nil?
      end
    end
    return (x_coordinate - new_x).abs <=1 && (y_coordinate - new_y).abs <=1
  end

  def move_to(x, y)
    if (x_coordinate - x).abs == 2
      if x_coordinate - x == 2
        castle_rook = game.pieces.find_by(type: "Rook", x_coordinate: 1, y_coordinate: y_coordinate)
        castle_rook.move!(x + 1, y)
      else
        castle_rook = game.pieces.find_by(type: "Rook", x_coordinate: 8, y_coordinate: y_coordinate)
        castle_rook.move!(x - 1, y)
      end
    end
    super
  end

  def castle_move?(new_x, new_y)
    if new_y == y_coordinate && (x_coordinate - new_x).abs == 2
      return true
    else
      return false
    end
  end
end
