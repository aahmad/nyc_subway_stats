require 'rails_helper'

RSpec.describe Division, type: :model do
  subject(:division) { create :division }

  it { is_expected.to have_many(:station_divisions) }
  it { is_expected.to have_many(:stations) }

  describe 'validations' do
    context 'when division is nil' do
      subject { build :division, division: nil }

      it { is_expected.to_not be_valid }
    end
  end
end
