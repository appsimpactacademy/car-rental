class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :set_layout

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:phone_number])
  end

  def set_layout
    if current_user && current_user.role == 'admin'
      'admin'
    else
      'application'
    end
  end

end
