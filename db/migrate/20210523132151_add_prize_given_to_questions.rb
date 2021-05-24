class AddPrizeGivenToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :prize_given, :boolean, default: false
  end
end
