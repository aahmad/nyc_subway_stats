class Station < ApplicationRecord
  lookup_by :station, find_or_create: true, cache: 500

  has_many :station_lines
  has_many :lines, through: :station_lines

  has_many :station_divisions
  has_many :divisions, through: :station_divisions

  has_many :station_events

  validates :station, presence: true
end
