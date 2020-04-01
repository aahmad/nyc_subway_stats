class CreateStationDivisions < ActiveRecord::Migration[6.0]
  def change
    create_table :divisions, primary_key: :division_id do |t|
      t.text :division, null: false
    end

    change_column :divisions, :division_id, :smallint
    add_index :divisions, :division, unique: true

    create_table :station_divisions, primary_key: :station_division_id do |t|
      t.references :division, null: false, type: :integer, limit: 2
      t.references :station, null: false, type: :integer, limit: 2
    end

    add_index :station_divisions, %i[division_id station_id], unique: true
  end
end
