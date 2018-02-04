class Pawn < Piece

  def is_valid?(new_x, new_y)
    return false unless super   
    return false unless allowed_move?(new_x, new_y)
    return false if opponent_here?(new_x, new_y) and not allowed_capture?(new_x, new_y)
    return true
  end

  def allowed_capture?(new_x, new_y)
    white ? allowed_diagonal = 1 : allowed_diagonal = -1
    return opponent_here?(new_x, new_y) && (new_y - y_coordinate) == allowed_diagonal && (new_x - x_coordinate).abs == 1 
  end

  def allowed_move?(new_x, new_y)
    white ? allowed_moves = [1] : allowed_moves = [-1]
    allowed_moves.push(allowed_moves[0]*2) if first_move?()
    return allowed_moves.include?(new_y - y_coordinate) && (new_x - x_coordinate).abs <= 1
  end

  def first_move?()
    return (white && y_coordinate == 2) || ((not white) && y_coordinate == 7) 
  end

  def opponent_here?(new_x, new_y)
    piece = Piece.where(game_id: game_id, x_coordinate: new_x, y_coordinate: new_y)
    if piece != []
      return piece.first.white != white
    else 
      return false
    end
  end
end
