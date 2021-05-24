class CreateMostRecentWins < ActiveRecord::Migration[6.1]
  def change
    create_table :most_recent_wins do |t|
      t.references :question, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
