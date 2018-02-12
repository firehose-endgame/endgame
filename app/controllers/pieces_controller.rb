class PiecesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
  end

  def update
    @piece = Piece.find_by_id(params[:id])
    @new_x = piece_params[:x_coordinate].to_i
    @new_y = piece_params[:y_coordinate].to_i
    
    if @piece.is_valid?(@new_x, @new_y)
      if @piece.move_to(@new_x, @new_y) === false
        flash[:alert] = "Invalid move"
      else
        redirect_to game_path(@piece.game)
      end
    else
      flash[:alert] = "Invalid move"
    end


  end


  def edit
    @piece = Piece.find(params[:id])
  end

  private

  def piece_params
    params.require(:piece).permit(:x_coordinate, :y_coordinate)
  end
end
