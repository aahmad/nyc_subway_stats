class Division < ApplicationRecord
  lookup_by :division, find_or_create: true, cache: 10

  has_many :station_divisions
  has_many :stations, through: :station_divisions

  validates :division, presence: true
end
