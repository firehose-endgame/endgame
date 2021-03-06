require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "games#new action" do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the new form" do
      user = FactoryBot.create(:user)
      sign_in user
      
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "games#create" do
    it "should require users to be logged in" do
      post :create, params: { game: { name: "Test" } }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new game in the database" do
      user = FactoryBot.create(:user)
      sign_in user     
      
      post :create, params: { game: { name: "Test" } }
      game = Game.last
      
      expect(response).to redirect_to game_path(game)
      expect(game.name).to eq("Test")
      expect(game.user).to eq(user)

    end

  end

  describe "games#show" do
    it "should successfully show the page if the game is found" do
      game = FactoryBot.create(:game)
      get :show, params: { id: game.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the game is not found" do
      get :show, params: { id: 'NOT ID' }
      expect(response).to have_http_status(:not_found)
    end

    it "should not create the pieces again when game is returned to" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, user_id: user.id)
      game_pieces = Piece.count
      get :show, params: { id: game.id }
      expect(game_pieces).to eq(Piece.count)
    end

    it "should reflect the current state of the game" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, user_id: user.id)
      move_piece = Piece.last
      move_piece.x_coordinate = 5
      move_piece.y_coordinate = 5
      get :show, params: { id: game.id }
      expect(move_piece.x_coordinate).to eq(5)
      expect(move_piece.y_coordinate).to eq(5)
    end
  end

  describe "games#update" do
    let(:game){FactoryBot.create(:game)}
    
    it "should allow a user to join a game" do
      user = FactoryBot.create(:user)
      sign_in user
      put :update, params: { id: game.id }
      
      game.reload
      expect(game.opponent_id).to eq(user.id)
    end

    it "should redirect to the game path" do
      user = FactoryBot.create(:user)
      sign_in user
      
      put :update, params: { id: game.id }
      expect(response).to redirect_to game_path(game)
    end

    it "should require users to be logged in" do
      put :update, params: { id: game.id }
      expect(response).to redirect_to new_user_session_path
    end

  end
end
