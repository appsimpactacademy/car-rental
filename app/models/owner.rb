class Owner < ApplicationRecord
	has_many :vehicles, dependent: :destroy
	
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
	validates :contact_number, presence: true, length: { minimum: 10, maximum: 10 }
	validates :city, :state, :country, presence: true

	has_one_attached :profile_image

end
