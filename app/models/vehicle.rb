class Vehicle < ApplicationRecord
  has_many :bookings
  belongs_to :owner, class_name: 'User'
  belongs_to :vehicle_type

  has_one_attached :cover_image
  has_many_attached :vehicle_images
  has_many_attached :documents


  enum verification_status: { pending: 'pending', verified: 'verified', unverified: 'unverified' }

  scope :available_between, ->(start_date, start_time, end_date, end_time) {
    start_datetime = DateTime.parse("#{start_date} #{start_time}")
    end_datetime = DateTime.parse("#{end_date} #{end_time}")
    where.not(id: Booking.where("(start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?)", end_datetime, start_datetime, end_datetime, start_datetime).select(:vehicle_id))
  }
  scope :includes_default, lambda {
    includes(
      :owner, 
      :vehicle_type,
      vehicle_images_attachments: :blob,
      documents_attachments: :blob,
      cover_image_attachment: :blob
    )
  }

  def self.ransackable_attributes(auth_object = nil)
    ["base_price", "created_at", "description", "fuel_type", "id", "name", "owner_id", "price_per_hour", "price_per_km", "registration_number", "updated_at", "vehicle_type_id"]
  end
end
