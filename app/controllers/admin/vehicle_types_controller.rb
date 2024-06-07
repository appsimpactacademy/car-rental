class Admin::VehicleTypesController < AdminController

	before_action :set_vehicle_type, only: [:show, :edit, :update, :destroy]

	def index
		@vehicle_types = VehicleType.all
	end

	def create
		@vehicle_type = VehicleType.create(vehicle_types_params)
		if @vehicle_type.save
			redirect_to admin_vehicle_types_path, notice: "Vehicle Type was successfully created."
		else
			render :new
		end
	end

	def new
		@vehicle_type = VehicleType.new
	end

	def edit
	end

	def show
	end

	def update
		if @vehicle_type.update(vehicle_types_params)
			redirect_to admin_vehicle_types_path, notice: "Vehicle Type was successfully updated."
		else
			render :edit
		end
	end

	def destroy
		if @vehicle_type.destroy
			redirect_to admin_vehicle_types_path, notice: "Vehicle Type was successfully destroyed."
		end
	end

	private

	def set_vehicle_type
		@vehicle_type = VehicleType.find(params[:id])
	end

	def vehicle_types_params
		params.require(:vehicle_type).permit(:name)
	end
end