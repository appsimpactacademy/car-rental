class Vehicle < ApplicationRecord
  belongs_to :owner
  belongs_to :vehicle_type

  has_one_attached :cover_image
  has_many_attached :vehicle_images
end
