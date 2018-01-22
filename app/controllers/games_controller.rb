
module GamesHelper
  
  def cell_black(row, column)
    if row % 2 == 0 && column % 2 == 0 || row % 2 != 0 && column % 2 != 0
      return true
    else
      return false
    end
  end

end


class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update]

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create(game_params)
    if @game.valid? 
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @game = Game.find_by_id(params[:id])
    render :status => 404 if @game.blank?
  end

  def update
    @game = Game.find_by_id(params[:id])
    @game.update(:opponent_id => current_user.id)
    redirect_to game_path(@game)
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
