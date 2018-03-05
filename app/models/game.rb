class Game < ApplicationRecord
	belongs_to :user
	has_many :pieces
  has_many :users

	scope :available, -> { where("user_id IS NOT NULL and opponent_id IS NULL") }

  validates :name, presence: true, length: { minimum: 2 }
  scope :available, -> { where(:opponent_id => nil) }

  after_create :populate_game!


  def populate_game!
    1.upto(8).each do |y_coord|
      1.upto(8).each do |x_coord|
        if y_coord <=2 || y_coord >= 7
          create_piece(x_coord, y_coord, piece_name(x_coord, y_coord))
        end
      end
    end
  end


  def piece_name(x_coord, y_coord)
    case y_coord
      when 2 , 7
        return "Pawn"
      when 1 , 8
        case x_coord
          when 1 , 8
            return "Rook"
          when 2 , 7
            return "Knight"
          when 3 , 6
            return "Bishop"
          when 4
            return "King"
          when 5
            return "Queen"
        end
    end
  end



  def create_piece(x, y, piece)
    Piece.create(x_coordinate: x, y_coordinate: y, type: piece, white: (y<=2), taken: false, game_id: id, selected: false, user_id:((y<=2)? user.id : nil))
  end

  def checkmate(white)
    king = pieces.find_by(type: 'King', white: white)
    king_x = king.x_coordinate
    king_y = king.y_coordinate
    if self.check?(white) == true
      arr = self.threatening_pieces(white)
      arr.each do |threatening_piece|
        if ((threatening_piece.x_coordinate - king_x).abs <=1 && (threatening_piece.y_coordinate - king_y).abs <=1)
          king.update_attributes!(x_coordinate: threatening_piece.x_coordinate ,y_coordinate: threatening_piece.y_coordinate)
          if self.check?(white) == true
            return true
          end
          return false
        elsif king.can_move_out_of_check?
          return false
        elsif threatening_piece.is_obstructable?#threatening_piece can be blocked by another piece
          return false
        else
          return true
        end
      end
    else
      return false
    end
  end

  def threatening_pieces(white)
    king = pieces.find_by(type: 'King', white: white)
    t_pieces = []
    other_pieces = pieces.where(" white != ? and x_coordinate > ?", white, 0)
    other_pieces.each do |piece|
      if piece.is_valid?(king.x_coordinate, king.y_coordinate)
        t_pieces << piece
      end
    end
    return t_pieces
  end

  def check?(white)
    if threatening_pieces(white).any?
      return true
    else
      return false
    end
  end
end
