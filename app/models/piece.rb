class Piece < ApplicationRecord
  belongs_to :game

  def is_obstructed?(new_x, new_y)
    old_x = self.x_coordinate
    old_y = self.y_coordinate
    line_type = self.direction_check(new_x, new_y, old_x, old_y)
    if line_type == 'invalid'

      return true

    elsif line_type == 'horizontal'

      old_x < new_x ? iteration = 1 : iteration = -1
      current_space = old_x + iteration
      return true if current_space == new_x
      while current_space != new_x
        return true if self.piece_here?(current_space, new_y)
        current_space += iteration
      end
      return false

    elsif line_type == 'vertical'

      old_y < new_y ? iteration = 1 : iteration = -1
      current_space = old_y + iteration
      return true if current_space == new_y
      while current_space != new_y
        return true if self.piece_here?(new_x, current_space)
        current_space += iteration
      end
      return false

    else

      old_x < new_x ? x_iteration = 1 : x_iteration = -1
      old_y < new_y ? y_iteration = 1 : y_iteration = -1
      current_x = old_x + x_iteration
      current_y = old_y + y_iteration
      return true if current_x == new_x
      while current_x != new_x
        return true if self.piece_here?(current_x, current_y)
        current_x += x_iteration
        current_y += y_iteration
      end
      return false

    end
  end

  def direction_check(new_x, new_y, old_x, old_y)
    if new_y == old_y
      return 'horizontal'
    elsif new_x == old_x
      return 'vertical'
    elsif self.diagonal?(new_x, new_y, old_x, old_y)
      return 'diagonal'
    else
      return 'invalid'
    end
  end

  def diagonal?(new_x, new_y, old_x, old_y)
    absolute_x = old_x - new_x
    absolute_x = absolute_x.abs
    absolute_y = old_y - new_y
    absolute_y = absolute_y.abs
    absolute_x == absolute_y ? true : false
  end

  def piece_here?(x, y)
    if Piece.where(game_id: self.game_id, x_coordinate: x, y_coordinate: y) == []
      return false
    else
      return true
    end
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
    self.update_attributes(x_coordinate: x, y_coordinate: y)
  end

  def same_square?(new_x, new_y)
    return new_x == self.x_coordinate && new_y == self.y_coordinate
  end

  def off_board?(new_x, new_y)
    return new_x > 8 || new_y > 8 || new_x < 1 || new_y < 1
  end

  def is_valid?(new_x, new_y)
    return false if off_board?(new_x, new_y)
    return false if same_square?(new_x, new_y)
    return false if is_obstructed?(new_x, new_y)
    return true
end

