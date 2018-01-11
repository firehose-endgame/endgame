class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
    	t.string :x_coordinate
      t.string :y_coordinate
      t.string :type
      t.boolean :white
      t.integer :user_id
      t.boolean :taken
      t.integer :game_id
      t.boolean :selected
      t.timestamps
    end
  end
end
