require 'rails_helper'

RSpec.describe StationEvent, type: :model do
  subject(:station_event) { create :station_event }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  describe 'validations' do
    describe '#station' do
      it { is_expected.to validate_presence_of(:station_id) }
    end

    describe '#event_at' do
      it { is_expected.to validate_presence_of(:event_at) }
    end
  end
end
