require 'rails_helper'

RSpec.describe FetchFileListings, type: :service do
  let(:service) { described_class.new }
  let(:site_html_file) { Rails.root.join('spec', 'support', 'turnstile.html') }
  let(:site_contents) { File.read(site_html_file) }

  describe '#execute' do
    before do
      stub_request(:get, 'http://web.mta.info/developers/turnstile.html')
        .to_return(status: 200, body: site_contents, headers: {})
    end

    it 'will parse the website for the data' do
      service.execute

      expect(FileDownload.count).to eq(20)
      expect(FileDownload.where(processed_at: nil).count).to eq(20)

      expect(FileDownload.first.url).to match(/turnstile_200328.txt/)
    end
  end
end
