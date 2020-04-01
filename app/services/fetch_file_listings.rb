class FetchFileListings
  BASE_DOWNLOAD_URL = 'http://web.mta.info/developers/data/nyct/turnstile'.freeze
  FILE_LISTINGS_URL = 'http://web.mta.info/developers/turnstile.html'.freeze
  URI_MATCH = %r{data\/nyct\/turnstile\/(turnstile_(\d{6}).txt)\Z}.freeze
  DATE_FORMAT_IN_FILENAME = '%y%m%d'.freeze
  MIN_DATE = Date.new(2014, 10, 18).freeze

  def initialize; end

  def execute
    file_names_and_dates.each do |file_and_date|
      filename = file_and_date[:filename]
      url = "#{BASE_DOWNLOAD_URL}/#{filename}"

      FileDownload.find_or_create_by(url: url)
    end
  end

  private

  def file_names_and_dates
    file_listings_url_source = HTTP.get(FILE_LISTINGS_URL).to_s

    Nokogiri::HTML(file_listings_url_source).css('a').map do |link|
      next unless link['href'].present?
      next unless link['href'] =~ URI_MATCH

      filename = Regexp.last_match[1]

      file_date = Date.strptime(Regexp.last_match[2], DATE_FORMAT_IN_FILENAME)
      next if file_date <= MIN_DATE

      { filename: filename, date: file_date }
    end.compact
  end
end
