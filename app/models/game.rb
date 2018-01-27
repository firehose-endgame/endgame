class Game < ApplicationRecord
	belongs_to :user
	has_many :pieces

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





end
