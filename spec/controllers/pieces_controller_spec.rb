require 'rails_helper'

RSpec.describe PiecesController, type: :controller do

  describe "pieces#update action" do
    before :each do
      @game = FactoryBot.create(:game)
      @piece = FactoryBot.create(:piece)
      @queen = Queen.create(x_coordinate: 4, y_coordinate: 4, game_id: @game.id, white: true, user_id: @game.user_id)
      @black_queen = Queen.create(x_coordinate: 6, y_coordinate: 5, game_id: @game.id, white: false, user_id: @game.opponent_id)
    end

    it "should successfully move_to new coordinates if move is_valid?" do
      put :update, params: { id: @queen.id, piece: { x_coordinate: 6, y_coordinate: 6 }}
      @queen.reload
      expect(@queen.x_coordinate).to eq 6
      expect(@queen.y_coordinate).to eq 6
    end

    it "should successfully capture a piece" do
      put :update, params: { id: @queen.id, piece: { x_coordinate: 7, y_coordinate: 4 }}
      @queen.reload
      expect(@queen.x_coordinate).to eq 7
      expect(@queen.y_coordinate).to eq 4
    end
    it "should not change a piece's location if the destination is invalid" do
      put :update, params: { id: @queen.id, piece: { x_coordinate: 5, y_coordinate: 6 }}
      @queen.reload
      expect(@queen.x_coordinate).to eq 4
      expect(@queen.y_coordinate).to eq 4
    end
    it "should not let a player move a piece that is not theirs/should not let a player move when it is not their turn" do
      put :update, params: { id: @black_queen.id, piece: { x_coordinate: 4, y_coordinate: 5}}
      expect(@black_queen.x_coordinate).to eq 6
      expect(@black_queen.y_coordinate).to eq 5
    end
  end
end
