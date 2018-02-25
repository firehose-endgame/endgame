class StaticPagesController < ApplicationController

  def index
  end


  def mygames
    @mygames ||= get_mygames
  end

  def get_mygames
      Game.where(:user_id => current_user)
      .or(Game.where(:opponent_id => current_user))
  end

end
