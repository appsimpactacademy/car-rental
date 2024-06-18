class Owner < ApplicationRecord
	has_many :vehicles, dependent: :destroy
	has_one_attached :profile_image
end
