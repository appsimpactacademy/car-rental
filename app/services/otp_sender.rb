# app/services/otp_sender.rb
class OtpSender
  def initialize(phone_number, otp)
    @phone_number = phone_number
    @otp = otp
  end

  def send_sms
    client = Twilio::REST::Client.new
    client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'], # Your Twilio number
      to: "+91#{@phone_number}",
      body: "Your OTP is #{@otp}"
    )
  end
end
