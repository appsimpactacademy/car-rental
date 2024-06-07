class VehicleType < ApplicationRecord
	has_many :vehicle, dependent: :destroy
	validates :name, presence: true
end
