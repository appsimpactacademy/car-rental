class Owner < ApplicationRecord
    # belongs_to :user
    has_many :vehicles

    validates :user_id, presence: true
end
