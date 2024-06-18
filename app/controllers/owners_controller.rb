class OwnersController < ApplicationController
	layout 'owner'
	before_action :authenticate_user!
	before_action :raise_access_denied

	private
	
  def raise_access_denied
    raise CanCan::AccessDenied.new("Not authorized!", Vehicle) unless current_user && current_user.is_owner?
  end
end
