class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :name
      t.string :picture_url
      t.references :user, foreign_key: true
      t.integer :stake

      t.timestamps
    end
  end
end
