class PiecesController < ApplicationController

  def create
  end

  def update
    @piece = Piece.find_by_id(params[:id])
    @piece.update_attributes(piece_params)
    redirect_to game_path(@piece.game)
  end

  def show
    @piece = Piece.find_by_id(params[:id])
    return render :status => 404 if @piece.blank?
    @pieces = @piece.game.pieces
    @game = @piece.game
  end

  def edit
    @piece = Piece.find(params[:id])
  end

  private

  def piece_params
    params.require(:piece).permit(:x_coordinate, :y_coordinate)
  end
end
