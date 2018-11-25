json.extract! admin, :id, :name, :email, :passowrd, :created_at, :updated_at
json.url admin_url(admin, format: :json)
