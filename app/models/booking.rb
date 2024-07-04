class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle

  STATUSES = %[pending accepted rejected].freeze

  validates :status, inclusion: { in: STATUSES }
  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date
  validate :vehicle_availability

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    errors.add(:end_date, "must be after the start date") if end_date <= start_date
  end

  def vehicle_availability
    existing_bookings = Booking.where(vehicle_id: vehicle_id)
                               .where.not(id: id) # Exclude the current booking in case of update
                               .where("start_date < ? AND end_date > ?", end_date, start_date)

    if existing_bookings.exists?
      errors.add(:vehicle_id, "is already booked for the selected date range")
    end
  end

  def calculate_total_amount
    # Combine date and time strings to create valid DateTime objects
    start_date_time = DateTime.parse("#{start_date}T#{start_time}:00")
    end_date_time = DateTime.parse("#{end_date}T#{end_time}:00")

    # Calculate the total number of days, considering partial days as full days
    time_difference = end_date_time.to_time - start_date_time.to_time
    total_days = (time_difference.to_f / 1.day).ceil

    # Adjust base price based on total days
    adjusted_base_price = vehicle.base_price * total_days

    # Calculate total amount based on the distance and price per kilometer
    total_amount = ((adjusted_base_price + (distance_per_km.to_f * vehicle.price_per_km)) * 2)

    total_amount
  end

  def self.ransackable_attributes(auth_object = nil)
    ["amount", "created_at", "end_date", "end_time", "id", "id_value", "start_date", "start_time", "status", "updated_at", "user_id", "vehicle_id"]
  end
end
