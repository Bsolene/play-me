class RemovePictureUrlFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :picture_url, :string
  end
end
