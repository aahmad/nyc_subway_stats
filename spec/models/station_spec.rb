require 'rails_helper'

RSpec.describe Station, type: :model do
  subject(:station) { create :station }

  it { is_expected.to have_many(:station_lines) }
  it { is_expected.to have_many(:station_divisions) }
  it { is_expected.to have_many(:station_events) }

  describe 'validations' do
    context 'when station is nil' do
      subject { build :station, station: nil }

      it { is_expected.to_not be_valid }
    end
  end
end
