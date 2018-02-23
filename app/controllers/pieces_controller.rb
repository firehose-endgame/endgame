class PiecesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
  end

  def update
    @piece = Piece.find_by_id(params[:id])
    @game = @piece.game
    @new_x = piece_params[:x_coordinate].to_i
    @new_y = piece_params[:y_coordinate].to_i
    if @game.current_turn_player_id === @piece.user_id
      if @piece.is_valid?(@new_x, @new_y)
        if @piece.move_to(@new_x, @new_y) === false
          flash[:alert] = invalid_move
          redirect_to game_path(@piece.game)
        else
          make_move(@new_x, @new_y, @piece)
          @game.update_attributes(current_turn_player_id: @game.opponent_id)
        end
      else
        flash[:alert] = invalid_move
        redirect_to game_path(@piece.game)
      end
    else
      flash[:alert] = "Not your turn"
    end
  end


  def make_move(new_x, new_y, piece)

    if piece.makes_check?(new_x, new_y)
      flash[:alert] = "Check!" 
    end

    if piece.promotable?(new_y)
      available_promotions = piece.promotable_pieces(new_x, new_y)
      render json: available_promotions
    else
      redirect_to game_path(piece.game)
    end

  end


  def promote_me
    id = params[:id]
    promotion = params[:promotion]
    Piece.where(:id => id).update_all(:type => promotion) 
    piece = Piece.find_by_id(id)
    redirect_to game_path(piece.game)
  end


  def edit
    @piece = Piece.find(params[:id])
  end

  private

  def piece_params
    params.require(:piece).permit(:x_coordinate, :y_coordinate, :type)
  end
end
