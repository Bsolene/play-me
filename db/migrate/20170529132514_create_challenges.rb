class CreateChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :challenges do |t|
      t.references :user, foreign_key: true
      t.references :game, foreign_key: true
      t.datetime :starts_at
      t.string :result
      t.boolean :accepted

      t.timestamps
    end
  end
end
