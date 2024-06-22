class VehiclesController < ApplicationController
	before_action :authenticate_user!
	before_action :check_owner_access
	before_action :set_vehicle, only: %i[show]

	def index
	  @q = Vehicle.includes(:owner, :vehicle_type, vehicle_images_attachments: :blob).ransack(params[:q])
	  @vehicles = @q.result

	  # Apply filtering based on start date/time and end date/time
	  if params[:start_date].present? && params[:start_time].present? && params[:end_date].present? && params[:end_time].present?
	    @vehicles = @vehicles.available_between(params[:start_date], params[:start_time], params[:end_date], params[:end_time])
	  end

	  # Apply filtering based on vehicle_type_id
	  @vehicles = @vehicles.by_vehicle_type(params[:vehicle_type_id]) if params[:vehicle_type_id].present?

	  # Apply filtering based on fuel_type
	  @vehicles = @vehicles.by_fuel_type(params[:fuel_type]) if params[:fuel_type].present?

	  respond_to do |format|
	    format.html
	    format.json { render json: @vehicles }
	  end
	end

	def show
		@owner = @vehicle.owner
		@related_vehicles = @owner.vehicles.where.not(id: @vehicle.id) # Exclude the current vehicle
	end

	private

	def set_vehicle
		@vehicle = Vehicle.includes(vehicle_images_attachments: :blob).find(params[:id])
	end

	def check_owner_access
    if current_user.is_owner?
      redirect_to owners_dashboard_path, alert: "Unauthorized access"
    end
  end
end
