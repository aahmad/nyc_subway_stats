require 'rails_helper'

RSpec.describe Line, type: :model do
  subject(:line) { create :line }

  it { is_expected.to have_many(:station_lines) }
  it { is_expected.to have_many(:stations) }

  describe 'validations' do
    context 'when line is nil' do
      subject { build :line, line: nil }

      it { is_expected.to_not be_valid }
    end
  end
end
