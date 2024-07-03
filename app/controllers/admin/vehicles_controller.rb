class Admin::VehiclesController < AdminController
  before_action :set_vehicle, only: [:show, :verify, :unverify]

  def index
    @vehicles = Vehicle.includes_default.order(created_at: :desc)
  end

  def show
    @owner = @vehicle.owner
  end

  def verify
    update_verification_status('verified', 'Vehicle has been verified.')
  end

  def unverify
    update_verification_status('unverified', 'Vehicle has been unverified.')
  end

  private

  def set_vehicle
    @vehicle = Vehicle.includes_default.find(params[:id])
  end

  def update_verification_status(status, notice)
    @vehicle.update(verification_status: status)
    redirect_to admin_vehicles_path, notice: notice
  end
end
