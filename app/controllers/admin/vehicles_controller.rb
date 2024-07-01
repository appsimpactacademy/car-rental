class Admin::VehiclesController < AdminController
	before_action :set_vehicle, only: [:show, :verify, :unverify]

	def index
		@vehicles = Vehicle.includes(:owner, :vehicle_type, vehicle_images_attachments: :blob, documents_attachments: :blob).order(created_at: :desc)
	end

	def show
		@owner = @vehicle.owner
	end

	def verify
    @vehicle.update(verification_status: 'verified')
    redirect_to admin_vehicles_path, notice: 'Vehicle has been verified.'
  end

  def unverify
    @vehicle.update(verification_status: 'unverified')
    redirect_to admin_vehicles_path, notice: 'Vehicle has been unverified.'
  end

	private

	def set_vehicle
		@vehicle = Vehicle.includes(vehicle_images_attachments: :blob).find(params[:id])
	end
end
