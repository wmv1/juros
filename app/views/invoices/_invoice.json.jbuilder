json.extract! invoice, :id, :amount, :due_date, :paid, :subscription_id, :installment_count, :current_installment, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
