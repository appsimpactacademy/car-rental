class AddAttrToVehicles < ActiveRecord::Migration[7.1]
  def change
    add_column :vehicles, :description, :text
  end
end
