class StationLine < ApplicationRecord
  validates :line, presence: true
  validates :station, presence: true

  belongs_to :station
  belongs_to :line
end
