require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe "pieces#update" do
    let(:piece){FactoryBot.create(:piece)}
    before do
      put :update, params: { id: piece.id, piece: { x_coordinate: 5, y_coordinate: 5 }}
    end   
    
    it "should allow users to update the coordinates" do
      piece.reload
      coordinates = [piece.x_coordinate, piece.y_coordinate]
      expect(coordinates).to eq([5, 5])
    end
  end

end
