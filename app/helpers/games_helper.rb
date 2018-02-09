module GamesHelper
  
  def cell_black(row, column)
    row % 2 == 0 && column % 2 == 0 || row % 2 != 0 && column % 2 != 0
  end

  def get_piece(piece_name, white)
  	case piece_name
      when "Pawn"
        (white)? "♙" : "♟"
      when "Rook"
        (white)? "♖" : "♜"
      when "Knight"
        (white)? "♘" : "♞"
      when "Bishop"
        (white)? "♗" : "♝"
      when "King"
        (white)? "♔" : "♚"
      when "Queen"
        (white)? "♕" : "♛"
    end
  end



end
