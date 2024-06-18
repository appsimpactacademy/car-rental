class AddPricePerHourToVehicles < ActiveRecord::Migration[7.1]
  def change
    add_column :vehicles, :price_per_hour, :decimal
  end
end
