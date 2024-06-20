class ChangeOwnerTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :owners, :name
    remove_column :owners, :email
    remove_column :owners, :contact_number
    remove_column :owners, :city
    remove_column :owners, :state
    remove_column :owners, :country
    add_reference :owners, :user, foreign_key: true
  end
end
