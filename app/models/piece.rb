class Piece < ApplicationRecord
  belongs_to :game

  def is_obstructed?(new_x, new_y)
    x_converter = { 'a' => 1, 'b' => 2, 'c' => 3, 'd' => 4, 'e' => 5, 'f' => 6, 'g' => 7, 'h' => 8 }
    x_searcher = { 1 => 'a', 2 => 'b', 3 => 'c', 4 => 'd', 5 => 'e', 6 => 'f', 7 => 'g', 8 => 'h' }
    new_x = x_converter[new_x]
    new_y = new_y.to_i
    old_x = x_converter[self.x_coordinate]
    old_y = y_coordinate.to_i
    line_type = self.direction_check(new_x, new_y, old_x, old_y)
    if line_type == 'invalid'

      return true

    elsif line_type == 'horizontal'

      old_x < new_x ? iteration = 1 : iteration = -1
      current_space = old_x + iteration
      return true if current_space == new_x
      while current_space != new_x
        return true if self.piece_here?(x_searcher[current_space], new_y.to_s)
        current_space += iteration
      end
      return false

    elsif line_type == 'vertical'

      old_y < new_y ? iteration = 1 : iteration = -1
      current_space = old_y + iteration
      return true if current_space == new_y
      while current_space != new_y
        return true if self.piece_here?(x_searcher[new_x], current_space.to_s)
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
        return true if self.piece_here?(x_searcher[current_x], current_y.to_s)
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
    if Piece.where("x_coordinate = ? AND y_coordinate = ?", x, y) == []
      return false
    else 
      return true
    end
  end
end
