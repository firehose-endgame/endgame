require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe "pieces#update" do
    let(:piece){FactoryBot.create(:piece)}
    before do
      put :update, params: { id: piece.id, piece: { x_coordinate: 5, y_coordinate: 5 }}
    end
    
    it "should redirect to the game show page" do
      expect(response).to redirect_to game_path(piece.game)
    end    
    
    it "should allow users to update the coordinates" do
      piece.reload
      coordinates = [piece.x_coordinate, piece.y_coordinate]
      expect(coordinates).to eq([5, 5])
    end
  end

  describe "pieces#show action" do
    it "should successfully show the page if the piece is found" do
      piece = FactoryBot.create(:piece)
      get :show, params: { id: piece.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the gram is not found" do
      get :show, params: { id: 'NOT ID' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "pieces#edit action" do
    it "should successfully show the edit form if the piece is found" do
      piece = FactoryBot.create(:piece)
      get :edit, params: { id: piece.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the gram is not found" do
      get :show, params: { id: 'NOT ID' }
      expect(response).to have_http_status(:not_found)
    end
  end
end
