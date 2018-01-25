class PiecesController < ApplicationController

  def create
  end

  def update
    @piece = Piece.find(params[:id])
    if @piece.update_attributes(piece_params)
      flash[:success] = "Your settings have been saved!"
      redirect_to game_path(@piece.game)
    else
      render text: "Not Saved"
    end
  end

  def show
    @piece = Piece.find_by_id(params[:id])
    @pieces = @piece.game.pieces
    render :status => 404 if @piece.blank?
    @game = @piece.game
  end

  def edit
    @piece = Piece.find(params[:id])
  end

  private

  def piece_params
    params.fetch(:piece, {}).permit(:x_coordinate, :y_coordinate)
  end
end
