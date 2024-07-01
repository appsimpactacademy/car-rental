class VehiclesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_owner_access
  before_action :set_vehicle, only: [:show, :send_message]

  def index
    @q = Vehicle.includes_default.ransack(params[:q])
    @vehicles = @q.result.verified

    apply_date_time_filter

    respond_to do |format|
      format.html
      format.json { render json: @vehicles }
    end
  end

  def show
    @owner = @vehicle.owner
    @related_vehicles = @owner.vehicles.includes_default.where.not(id: @vehicle.id)
  end

  def send_message
    rentee_name = params[:name]
    rentee_email = params[:email]
    rentee_phone = params[:phone_number]

    NotificationMailer.contact_owner(
      @vehicle, rentee_name, rentee_email, rentee_phone
    ).deliver_now

    redirect_to @vehicle, notice: 'Message sent to the owner.'
  end

  private

  def set_vehicle
    @vehicle = Vehicle.includes_default.find(params[:id])
  end

  def check_owner_access
    redirect_to owners_dashboard_path, alert: 'Unauthorized access' if current_user&.is_owner?
  end

  def apply_date_time_filter
    return unless date_time_filter_params_present?

    @vehicles = @vehicles.available_between(
      params[:start_date], params[:start_time],
      params[:end_date], params[:end_time]
    )
  end

  def date_time_filter_params_present?
    params[:start_date].present? && params[:start_time].present? &&
      params[:end_date].present? && params[:end_time].present?
  end
end
