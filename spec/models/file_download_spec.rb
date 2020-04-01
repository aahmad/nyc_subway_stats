require 'rails_helper'

RSpec.describe FileDownload, type: :model do
  subject(:file_download) { create :file_download, url: '/data/something.txt' }

  it { is_expected.to have_many(:station_events) }

  describe '#filename' do
    it 'the base of the url' do
      expect(subject.filename).to eq('something.txt')
    end
  end

  describe '#local_file' do
    it 'concats the download path with the filename' do
      expect(subject.local_file).to eq("#{FileDownload::FILE_DOWNLOAD_PATH}/something.txt")
    end
  end

  describe 'validations' do
    context 'when url is nil' do
      subject { build :file_download, url: nil }

      it { is_expected.to_not be_valid }
    end
  end
end
