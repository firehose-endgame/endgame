module GamesHelper
  
  def cell_black(row, column)
    row % 2 == 0 && column % 2 == 0 || row % 2 != 0 && column % 2 != 0
  end



end
