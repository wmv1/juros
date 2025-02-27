json.extract! subscription, :id, :amount, :start_date, :status, :contract_id, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)
