class CreateOwners < ActiveRecord::Migration[7.1]
  def change
    create_table :owners do |t|
      t.string :name
      t.string :email
      t.string :contact_number
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
