class CreateStations < ActiveRecord::Migration[6.0]
  def change
    create_lookup_table :stations, small: true
  end
end
