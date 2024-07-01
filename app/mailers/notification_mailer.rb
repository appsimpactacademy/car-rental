class NotificationMailer < ApplicationMailer
	default from: 'no-reply@example.com'

  def contact_owner(vehicle, rentee_name, rentee_email, rentee_phone)
    @vehicle = vehicle
    @rentee_name = rentee_name
    @rentee_email = rentee_email
    @rentee_phone = rentee_phone
    @owner = @vehicle.owner

    mail(to: @owner.email, subject: 'New enquiry from a rentee')
  end
end
