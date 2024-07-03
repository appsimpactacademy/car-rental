class Owners::VehiclesController < OwnersController
	before_action :authenticate_user!
	before_action :set_vehicle, only: [:show, :edit, :update, :destroy]

	def index
		@vehicles = Vehicle.includes_default.where(owner_id: current_user.id) if current_user.is_owner?
	end

	def new
		@vehicle = Vehicle.new
	end

	def create
	  @vehicle = Vehicle.new(vehicle_params)
	  attach_files(@vehicle, :vehicle_images)
	  attach_files(@vehicle, :documents)

	  if @vehicle.save
	    redirect_to owners_vehicle_path(@vehicle), notice: "Vehicle was successfully created."
	  else
	    render :new, status: :unprocessable_entity
	  end
	end

	def show
	  @owner = @vehicle.owner
	  @related_vehicles = @owner.vehicles.includes_default.where.not(id: @vehicle.id)
	end

	def edit
	end

	def update
	  attach_files(@vehicle, :vehicle_images)
	  attach_files(@vehicle, :documents)

	  if @vehicle.update(vehicle_params)
	    redirect_to owners_vehicles_path, notice: "Vehicle was successfully updated."
	  else
	    render :edit, status: :unprocessable_entity
	  end
	end

	def destroy
		@vehicle.destroy
		redirect_to owners_vehicles_path, notice: "Vehicle was successfully destroyed."
	end

	private

	def set_vehicle
		@vehicle = Vehicle.includes_default.find(params[:id])
	end

	def attach_files(vehicle, file_type)
	  if params[:vehicle][file_type].present?
	    params[:vehicle][file_type].each do |file|
	      vehicle.send(file_type).attach(file)
	    end
	  end
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
