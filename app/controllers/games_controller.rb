

class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update]

  def index
    @games = Game.available
  end

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
    return render :status => 404 if @game.blank?
    @pieces = @game.pieces.all
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
