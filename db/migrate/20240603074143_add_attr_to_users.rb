class AddAttrToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :username, :string
    add_column :users, :phone_number, :string
    add_column :users, :otp, :string
    add_column :users, :otp_sent_at, :datetime
  end
end
