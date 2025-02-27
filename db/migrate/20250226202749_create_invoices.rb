class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.decimal :amount
      t.date :due_date
      t.boolean :paid
      t.references :subscription, null: false, foreign_key: true
      t.integer :installment_count
      t.integer :current_installment

      t.timestamps
    end
  end
end
