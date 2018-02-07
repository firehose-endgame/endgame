class PiecesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
  end

  def update
    piece = Piece.find(params[:id])
    piece.update_attributes(piece_params)
    render json: piece
  end


 

  private

  def piece_params
    params.require(:piece).permit(:x_coordinate, :y_coordinate)
  end
end
