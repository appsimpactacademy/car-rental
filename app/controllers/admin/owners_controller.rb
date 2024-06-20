class Admin::OwnersController < AdminController
	def index
		@owners = User.where(role: 'owner')
	end
end