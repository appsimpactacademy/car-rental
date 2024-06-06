class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  validates :first_name, 
            :last_name, 
            :username, 
             presence: true
  validates :phone_number, presence: true, 
                             uniqueness: true, 
                             length: { minimum: 10, maximum: 10 }, 
                             numericality: { only_integer: true }


  def generate_otp
    self.otp = rand.to_s[2..7]  # Generate a 6-digit OTP
    self.otp_sent_at = Time.now.utc
    save!
    return self.otp
  end

  def otp_valid?(submitted_otp)
    return false if otp.blank? || otp_sent_at.blank?
    return false if otp_sent_at < 10.minutes.ago # OTP expires after 10 minutes
    otp == submitted_otp
  end

  def is_admin?
    role == 'admin'
  end                        
end
