class CreateTranscripts < ActiveRecord::Migration[5.1]
  def change
    create_table :transcripts do |t|
      t.string :title, limit:100, null:false
      t.string :filename
      t.longblob :file
      t.string :content_type, null:false
      t.text :description
      t.string :tag, limit:100
      t.string :user_id, limit:80, null:false

      t.timestamps
    end
  end
end
