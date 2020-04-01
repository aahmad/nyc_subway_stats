class CreateStationEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :station_events, primary_key: :station_event_id do |t|
      t.references :file_download, null: false

      t.text :control_area, null: false
      t.text :unit, null: false
      t.text :scp, null: false

      t.references :station, null: false, type: :integer, limit: 2

      t.timestamp :event_at, null: false

      t.text :description

      t.bigint :entries, null: false
      t.bigint :exits, null: false

      t.timestamps
    end

    add_index :station_events, %i[control_area scp event_at], unique: true
    add_index :station_events, :event_at
    add_index :station_events, :entries
    add_index :station_events, :exits
  end
end
