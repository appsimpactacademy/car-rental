class ChangeStartTimeTypeInBookings < ActiveRecord::Migration[7.1]
  def up
    change_column :bookings, :start_time, :time
    change_column :bookings, :end_time, :time
  end

  def down
    change_column :bookings, :start_time, :datetime # or the previous type
    change_column :bookings, :end_time, :datetime # or the previous type
  end
end
