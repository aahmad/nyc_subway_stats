class StationDivision < ApplicationRecord
  validates :division, presence: true

  belongs_to :station
  belongs_to :division
end
