class Vehicle < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :vehicle_type

  has_one_attached :cover_image
  has_many_attached :vehicle_images

  has_many :bookings
end
