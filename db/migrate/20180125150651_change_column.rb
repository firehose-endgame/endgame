class ChangeColumn < ActiveRecord::Migration[5.0]
  def change
  	change_column :pieces, :x_coordinate, 'integer USING CAST(x_coordinate AS integer)'
    change_column :pieces, :y_coordinate, 'integer USING CAST(x_coordinate AS integer)'
  end
end
