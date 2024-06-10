class VehicleType < ApplicationRecord
	has_many :vehicles, dependent: :destroy
	validates :name, presence: true
end
