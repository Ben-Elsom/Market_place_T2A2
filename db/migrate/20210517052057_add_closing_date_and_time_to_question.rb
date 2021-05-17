class AddClosingDateAndTimeToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :closing_date_and_time, :datetime
  end
end
