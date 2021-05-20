class AddBalanceToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :Balance, :float, default: 10
  end
end
