class BookingMailer < ApplicationMailer
	def booking_notification_email(owner, booking)
    @owner = owner
    @booking = booking
    mail(to: @owner.email, subject: 'New Booking Notification')
  end
end
