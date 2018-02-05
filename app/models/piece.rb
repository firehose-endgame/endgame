class Piece < ApplicationRecord
  belongs_to :game

  def is_obstructed?(new_x, new_y)

    if is_valid_horizontal?(new_y)

      x_coordinate < new_x ? iteration = 1 : iteration = -1
      current_space = x_coordinate + iteration
      while current_space != new_x
        return true if self.piece_here?(current_space, new_y)
        current_space += iteration
      end
      return false

    elsif is_valid_vertical?(new_x)

      y_coordinate < new_y ? iteration = 1 : iteration = -1
      current_space = y_coordinate + iteration
      while current_space != new_y
        return true if self.piece_here?(new_x, current_space)
        current_space += iteration
      end
      return false

    elsif is_valid_diagonal?(new_x, new_y)
      
      x_coordinate < new_x ? x_iteration = 1 : x_iteration = -1
      y_coordinate < new_y ? y_iteration = 1 : y_iteration = -1
      current_x = x_coordinate + x_iteration
      current_y = y_coordinate + y_iteration
      while current_x != new_x
        return true if self.piece_here?(current_x, current_y)
        current_x += x_iteration
        current_y += y_iteration
      end
      return false

    else

      return true
    
    end
  end

  def is_valid_diagonal?(new_x, new_y)
    return (new_x - x_coordinate).abs == (new_y - y_coordinate).abs
  end

  def is_valid_straight?(new_x, new_y)
    return new_x == x_coordinate || new_y == y_coordinate
  end

  def is_valid_horizontal?(new_y)
    return new_y == y_coordinate
  end

  def is_valid_vertical?(new_x)
    return new_x == x_coordinate
  end

  def piece_here?(x, y)
    @other_piece = game.pieces.find_by(x_coordinate: x, y_coordinate: y)
    @other_piece.nil? ? false : true
  end

  def own_here?(new_x, new_y)
    @other_piece.white == white
  end

  def move_to(x, y)
    if piece_here?(x, y)
      other_piece = Piece.where(game_id: game_id, x_coordinate: x, y_coordinate: y).first
      if other_piece.white != self.white
        capture!(other_piece)
        move!(x, y)
      end
    else
      move!(x, y)
    end
  end

  def capture!(piece)
    piece.update_attributes(x_coordinate: 0, y_coordinate: 0, taken: true)
  end

  def move!(x, y)
    self.update_attributes(x_coordinate: x, y_coordinate: y, moved: true)
  end

  def same_square?(new_x, new_y)
    return new_x == self.x_coordinate && new_y == self.y_coordinate
  end

  def off_board?(new_x, new_y)
    return new_x > 8 || new_y > 8 || new_x < 1 || new_y < 1
  end

  def is_valid?(new_x, new_y)
    return false if off_board?(new_x, new_y) || same_square?(new_x, new_y) || is_obstructed?(new_x, new_y)
    return false if piece_here?(new_x, new_y) && own_here?(new_x, new_y)
    return true
  end
end
