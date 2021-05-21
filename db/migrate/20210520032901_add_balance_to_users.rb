class AddBalanceToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :balance, :float, default: 200, precision: 2
  end
end
