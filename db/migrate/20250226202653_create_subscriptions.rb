class CreateSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :subscriptions do |t|
      t.decimal :amount
      t.date :start_date
      t.integer :status, default: 0
      t.references :contract, null: false, foreign_key: true

      t.timestamps
    end
  end
end
