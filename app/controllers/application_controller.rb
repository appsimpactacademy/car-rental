class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:phone_number])
  end

  def layout_by_resource
    if user_signed_in? && current_user.is_admin?
      'admin'
    else
      'application'
    end
  end

  def after_sign_in_path_for(resource)
    if resource.is_admin?
      admin_dashboard_path
    elsif resource.is_owner?
      owners_dashboard_path
    else
      root_path
    end
  end
end
