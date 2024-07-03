class Owners::DashboardController < OwnersController

  def index
    @vehicles = Vehicle.includes_default.where(owner_id: current_user.id) if current_user.is_owner?
  end

end