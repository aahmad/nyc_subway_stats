class CreateFileDownloads < ActiveRecord::Migration[6.0]
  def change
    create_table :file_downloads, primary_key: :file_download_id do |t|
      t.text :url
      t.timestamp :processed_at

      t.timestamps
    end
  end
end
