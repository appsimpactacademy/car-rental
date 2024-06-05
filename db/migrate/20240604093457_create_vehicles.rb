class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.string :registration_number
      t.references :owner, null: false, foreign_key: true
      t.references :vehicle_type, null: false, foreign_key: true
      t.decimal :base_price
      t.decimal :price_per_km
      t.string :name
      t.string :fule_type

      t.timestamps
    end
  end
end
