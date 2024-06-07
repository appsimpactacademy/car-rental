class Owner < ApplicationRecord
	has_many :vehicle, dependent: :destroy
	
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
	validates :contact_number, presence: true, length: { minimum: 10, maximum: 10 }
	validates :city, :state, :country, presence: true
end
