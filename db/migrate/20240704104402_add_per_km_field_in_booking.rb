class AddPerKmFieldInBooking < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :distance_per_km, :string
  end
end
