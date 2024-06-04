# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def login_with_phone_number
    phone_number = params[:phone_number]
    user = find_user_by_phone_number(phone_number)
    if user.present?
      otp = user.generate_otp
      OtpSender.new(phone_number, otp).send_sms
      session[:phone_number] = phone_number  # Store phone number in session
      redirect_to otp_page_path
    else
      flash[:alert] = "Invalid phone number. Please try again or sign up."
      redirect_to new_user_session_path
    end
  end

  def otp_page;end

  def verify_otp
    submitted_otp = params[:otp]
    phone_number = session[:phone_number]  # Retrieve phone number from session
    user = find_user_by_phone_number(phone_number)
    if user.present? && user.otp_valid?(submitted_otp)
      sign_in(user)
      session.delete(:phone_number)  # Remove phone number from session after successful login
      redirect_to root_path
    else
      flash[:alert] = "Invalid OTP. Please try again."
      redirect_to otp_page_path
    end
  end
  
  private

  def find_user_by_phone_number(phone_number)
    User.find_by(phone_number: phone_number)
  end
end
