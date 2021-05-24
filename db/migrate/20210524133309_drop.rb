class Drop < ActiveRecord::Migration[6.1]
  def change
    drop_table :most_recent_winners
  end
end
