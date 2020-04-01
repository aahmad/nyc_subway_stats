class FileDownload < ApplicationRecord
  has_many :station_events

  FILE_DOWNLOAD_PATH = File.join(Rails.root, 'tmp', 'file_downloads').freeze
  validates :url, presence: true

  def filename
    uri = URI.parse(url)
    File.basename(uri.path)
  end

  def local_file
    "#{FILE_DOWNLOAD_PATH}/#{filename}"
  end

  def download_and_save!(force_redownload: false)
    return if File.exist?(local_file) && !force_redownload

    Dir.mkdir(FILE_DOWNLOAD_PATH) unless Dir.exist?(FILE_DOWNLOAD_PATH)

    File.write(local_file, HTTP.get(url))
  end
end
