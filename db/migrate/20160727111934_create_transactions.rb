class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.float :amount
      t.string :transaction_number

      t.timestamps
    end
  end
end
