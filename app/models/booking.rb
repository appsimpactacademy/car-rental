class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle

  STATUSES = %[pending accepted rejected].freeze

  validates :status, inclusion: { in: STATUSES }
  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date
  validate :user_can_book_once_per_day, on: :create

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    errors.add(:end_date, "must be after the start date") if end_date <= start_date
  end

  def user_can_book_once_per_day
    if user && user.bookings.where("DATE(start_date) = ?", start_date.to_date).exists?
      errors.add(:user_id, "has already booked a vehicle for this day")
    end
  end

  def calculate_total_amount
    # Calculate total duration in hours
    total_hours = ((end_date - start_date) * 24) + (end_time.hour - start_time.hour) + (end_time.min - start_time.min) / 60.0
    
    # Calculate total amount based on price per hour
    total_amount = total_hours * vehicle.price_per_hour

    total_amount
  end

end
