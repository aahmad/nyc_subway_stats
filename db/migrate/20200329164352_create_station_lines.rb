class CreateStationLines < ActiveRecord::Migration[6.0]
  def change
    create_table :lines, primary_key: :line_id do |t|
      t.text :line, null: false
    end

    change_column :lines, :line_id, :smallint
    add_index :lines, :line, unique: true

    create_table :station_lines, primary_key: :station_line_id do |t|
      t.references :line, null: false, type: :integer, limit: 2
      t.references :station, null: false, type: :integer, limit: 2
    end

    add_index :station_lines, %i[line_id station_id], unique: true
  end
end
