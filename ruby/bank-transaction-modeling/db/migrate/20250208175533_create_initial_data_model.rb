class CreateInitialDataModel < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.timestamps
      t.integer :amount, null: false
      t.references :src_account, foreign_key: { to_table: :accounts }
      t.references :dst_account, foreign_key: { to_table: :accounts }
    end

    create_table :accounts do |t|
      t.timestamps
      t.integer :balance, null: false, default: 0
      t.string :account_type, null: false
    end
  end
end
