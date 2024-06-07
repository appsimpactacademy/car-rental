class Admin::VehiclesController < AdminController
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
			redirect_to admin_vehicles_path, notice: "Vehicle was successfully created."
		else
			render :new, status: :unprocessable_entity
		end
	end

	def show
	end

	def edit
	end

	def update
		if @vehicle.vehicle_images.present? && params[:vehicle][:vehicle_images].present? ||  params[:vehicle][:vehicle_images].present?
			params[:vehicle][:vehicle_images].each do |image|
        @vehicle.vehicle_images.attach(image)
      end
		end
		if @vehicle.update(vehicle_params)
			redirect_to admin_vehicles_path, notice: "Vehicle was successfully updated."
		else
			render :edit, status: :unprocessable_entity			
		end
	end

	def destroy
		@vehicle.destroy
		redirect_to admin_vehicles_path, notice: "Vehicle was successfully destroyed."
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
			:fule_type,
			:cover_image
		)
	end
end
