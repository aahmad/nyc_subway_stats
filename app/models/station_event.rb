class StationEvent < ApplicationRecord
  validates :station_id, presence: true
  validates :event_at, presence: true

  belongs_to :file_download

  lookup_for :station
end
