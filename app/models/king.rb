class King < Piece

  def is_valid?(new_x, new_y)
    return false unless super
    return (x_coordinate - new_x).abs <=1 && (y_coordinate - new_y).abs <=1
  end

  def can_move_out_of_check?
    p self
    initial_x = x_coordinate
    initial_y = y_coordinate
    x = [initial_x - 1, initial_x + 1]
    y = [initial_y - 1, initial_y + 1]
    x.each do |x_coord|
      y.each do |y_coord|
        if is_valid?(x_coord, y_coord)
          update_attributes(x_coordinate: x_coord, y_coordinate: y_coord)
          p self
          if game.check?(white) == false
            update_attributes(x_coordinate: initial_x, y_coordinate: initial_y)
            return true
          else
            return false
          end
        else
          return true
        end
      end
    end
  end
end
