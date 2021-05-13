class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :description
      t.integer :prize
      t.float :response_cost

      t.timestamps
    end
  end
end
