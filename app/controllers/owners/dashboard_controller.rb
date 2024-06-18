class Owners::DashboardController < OwnersController

  def index
    @vehicles = Vehicle.where(owner_id: current_user.id) if current_user.is_owner?
  end

end