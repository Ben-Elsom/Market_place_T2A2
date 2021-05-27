class CreateMostRecentWins < ActiveRecord::Migration[6.1]
  def change
    create_table :most_recent_wins do |t|
      t.string :title
      t.float :prize
      t.string :user
      t.string :comment

      t.timestamps
    end
  end
end
