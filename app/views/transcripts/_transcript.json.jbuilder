json.extract! transcript, :id, :title, :filename, :file, :content_type, :description, :tag, :user_id, :created_at, :updated_at
json.url transcript_url(transcript, format: :json)
