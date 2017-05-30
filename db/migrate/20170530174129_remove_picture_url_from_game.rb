class RemovePictureUrlFromGame < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :picture_url, :string
  end
end
