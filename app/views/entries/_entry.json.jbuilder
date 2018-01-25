json.extract! entry, :id, :amount, :comment, :user_id, :category_id, :created_at, :updated_at
json.url entry_url(entry, format: :json)
