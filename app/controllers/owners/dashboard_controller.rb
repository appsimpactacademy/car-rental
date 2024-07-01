class Owners::DashboardController < OwnersController

  def index
    @vehicles = Vehicle.includes(:owner, :vehicle_type, vehicle_images_attachments: :blob, documents_attachments: :blob).where(owner_id: current_user.id) if current_user.is_owner?
  end

end