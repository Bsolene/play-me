class AddColumnWinnerToChallenges < ActiveRecord::Migration[5.0]
  def change
    add_column :challenges, :winner, :boolean
  end
end
