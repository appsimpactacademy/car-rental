class Vehicle < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :vehicle_type

  has_one_attached :cover_image
  has_many_attached :vehicle_images

  has_many :bookings

  def self.ransackable_attributes(auth_object = nil)
    ["base_price", "created_at", "description", "fuel_type", "id", "id_value", "name", "owner_id", "price_per_hour", "price_per_km", "registration_number", "updated_at", "vehicle_type_id"]
  end

  scope :available_between, ->(start_date, start_time, end_date, end_time) {
    start_datetime = DateTime.parse("#{start_date} #{start_time}")
    end_datetime = DateTime.parse("#{end_date} #{end_time}")
    where.not(id: Booking.where("(start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?)", end_datetime, start_datetime, end_datetime, start_datetime).select(:vehicle_id))
  }

  scope :by_vehicle_type, ->(vehicle_type_id) { where(vehicle_type_id: vehicle_type_id) if vehicle_type_id.present? }
  scope :by_fuel_type, ->(fuel_type) { where(fuel_type: fuel_type) if fuel_type.present? }
end
