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

  def promotable?(new_y)
    return true if type == "Pawn" && (white && new_y==8 || !white && new_y==1) 
    return false
  end

  def promotable_pieces(new_x, new_y)
    promotions_possible = ["Queen", "Bishop", "Knight", "Rook"]
    promotions_available = []
    promotions_possible.each do |piece|
      self.type = piece
      promotions_available << piece unless self.is_stalemate?
    end
    self.type = "Pawn"
    return promotions_available
  end


end
