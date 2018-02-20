class Pawn < Piece

  def is_valid?(new_x, new_y)
    return false unless super   
    return false unless allowed_move?(new_x, new_y)
    return false if (piece_here?(new_y, new_y) and not own_here?(new_x, new_y)) and not allowed_capture?(new_x, new_y)
    return true
  end

  def allowed_capture?(new_x, new_y)
    white ? allowed_diagonal = 1 : allowed_diagonal = -1
    return (new_y - y_coordinate) == allowed_diagonal && (new_x - x_coordinate).abs == 1 
  end

  def allowed_move?(new_x, new_y)
    white ? allowed_moves = [1] : allowed_moves = [-1]
    allowed_moves.push(allowed_moves[0]*2) if not moved
    return allowed_moves.include?(new_y - y_coordinate) && (new_x - x_coordinate).abs <= 1
  end


end
