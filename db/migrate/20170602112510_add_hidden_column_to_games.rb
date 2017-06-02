class AddHiddenColumnToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :hidden, :boolean
  end
end
