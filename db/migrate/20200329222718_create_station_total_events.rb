class CreateStationTotalEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :station_total_events, primary_key: :station_total_event_id do |t|
      t.references :station_event, null: false

      t.bigint :entries, null: false
      t.bigint :exits, null: false

      t.timestamps
    end

    add_index :station_total_events, :entries
    add_index :station_total_events, :exits
  end
end
