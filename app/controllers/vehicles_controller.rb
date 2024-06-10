class VehiclesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_vehicle, only: [:show, :edit, :update, :destroy]

	def index
		@vehicles = Vehicle.all.includes(:owner, :vehicle_type, vehicle_images_attachments: :blob).order(created_at: :desc)
	end

	def new
		@vehicle = Vehicle.new
	end

	def create
		@vehicle = Vehicle.new(vehicle_params)
		# Save uploaded images directly without relying on params
    if params[:vehicle][:vehicle_images].present?
      params[:vehicle][:vehicle_images].each do |image|
        @vehicle.vehicle_images.attach(image)
      end
    end
		if @vehicle.save
			redirect_to @vehicle, notice: "Vehicle was successfully created."
		else
			render :new, status: :unprocessable_entity
		end
	end

	def show
		@owner = @vehicle.owner
		@related_vehicles = @owner.vehicles.where.not(id: @vehicle.id) # Exclude the current vehicle
	end

	def edit
	end

	def update
    if params[:vehicle][:vehicle_images].present? && (@vehicle.vehicle_images.present? || !@vehicle.vehicle_images.present?)
			params[:vehicle][:vehicle_images].each do |image|
        @vehicle.vehicle_images.attach(image)
      end
		end
		if @vehicle.update(vehicle_params)
			redirect_to @vehicle, notice: "Vehicle was successfully updated."
		else
			render :edit, status: :unprocessable_entity			
		end
	end

	def destroy
		@vehicle.destroy
		redirect_to vehicles_path, notice: "Vehicle was successfully destroyed."
	end

	private

	def set_vehicle
		@vehicle = Vehicle.includes(vehicle_images_attachments: :blob).find(params[:id])
	end

	def vehicle_params
		params.require(:vehicle).permit(
			:registration_number,
			:owner_id,
			:vehicle_type_id,
			:base_price,
			:price_per_km,
			:name,
			:fuel_type,
			:cover_image,
			:description
		)
	end
end
