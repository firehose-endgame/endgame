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


  def assign_opponent(game, opponent)
    Game.where(:id => game).update_all(:opponent_id => opponent)
    Piece.where(:game_id => game, :white => false).update_all(:user_id => opponent)
  end



end
