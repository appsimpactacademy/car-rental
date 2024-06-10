class ChangeColumnNameInVehicle < ActiveRecord::Migration[7.1]
  def change
    rename_column :vehicles, :fule_type, :fuel_type
  end
end
