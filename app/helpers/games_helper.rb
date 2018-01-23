module GamesHelper
  
  def cell_black(row, column)
    if row % 2 == 0 && column % 2 == 0 || row % 2 != 0 && column % 2 != 0
      return true
    else
      return false
    end
  end

end
