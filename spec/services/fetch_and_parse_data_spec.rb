require 'rails_helper'

RSpec.describe FetchAndParseData, type: :service do
  let(:service) { described_class.new(verbose: false) }

  describe '#execute' do
    let!(:file_download) { create :file_download, url: '/turnstile/turnstile_200328.txt' }
    let(:file_location) { Rails.root.join('spec', 'support', 'turnstile_200328.txt') }

    it 'will import and parse a downloaded file' do
      # Read the file from spec/support
      allow_any_instance_of(FileDownload).to receive(:local_file).and_return(file_location)

      service.execute

      file_download.reload

      expect(file_download.processed_at).to be_present
      expect(file_download.station_events.count).to eq(10)

      expect(Station.all.map(&:station).sort).to eq(['42 ST-BRYANT PK', '59 ST'])

      bryant_park = Station['42 ST-BRYANT PK']
      fifety_nine_street = Station['59 ST']

      expect(bryant_park.station_events.count).to eq(1)
      expect(fifety_nine_street.station_events.count).to eq(9)

      expect(bryant_park.divisions.map(&:division)).to eq(%w[IND])
      expect(fifety_nine_street.divisions.map(&:division)).to eq(%w[BMT])

      expect(bryant_park.lines.map(&:line).sort).to eq(%w[7 B D F M])
      expect(fifety_nine_street.lines.map(&:line).sort).to eq(%w[4 5 6 N Q R W])
    end
  end
end
