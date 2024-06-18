class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle

  STATUSES = %[pending accepted rejected].freeze

  validates :status, inclusion: { in: STATUSES }

  after_initialize :set_default_status, if: :new_record?

  def set_default_status
    self.status ||= 'pending'
  end

  def calculate_total_amount
    # Calculate total duration in hours
    total_hours = ((end_date - start_date) * 24) + (end_time.hour - start_time.hour) + (end_time.min - start_time.min) / 60.0
    
    # Calculate total amount based on price per hour
    total_amount = total_hours * vehicle.price_per_hour

    total_amount
  end

end
