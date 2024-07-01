class AddVerificationStatusToVehicles < ActiveRecord::Migration[7.1]
  def change
    add_column :vehicles, :verification_status, :string
  end
end
