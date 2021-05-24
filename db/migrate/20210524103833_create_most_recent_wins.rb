class CreateMostRecentWins < ActiveRecord::Migration[6.1]
  def change
    create_table :most_recent_wins do |t|
      t.string :title
      t.string :username
      t.float :prize
      t.text :comment

      t.timestamps
    end
  end
end
