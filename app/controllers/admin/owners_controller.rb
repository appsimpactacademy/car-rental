class Admin::OwnersController < AdminController
	before_action :set_owner, only: [:show, :edit, :update, :destroy]
	def index
		@owners = Owner.all
	end

	def create
		@owner = Owner.create(owner_params)
		if @owner.save
			redirect_to admin_owners_path, notice: "Owner was successfully created."
		else
			render :new
		end
	end

	def new
		@owner = Owner.new
	end

	def edit
	end

	def show
	end

	def update
		if @owner.update(owner_params)
			redirect_to admin_owners_path, notice: "Owner was successfully updated."
		else
			render :edit
		end
	end

	def destroy
		if @owner.destroy
			redirect_to admin_owners_path, notice: "Owner was successfully destroyed."
		end
	end

	private

	def set_owner
		@owner = Owner.find(params[:id])
	end

	def owner_params
		params.require(:owner).permit(:name, :email, :contact_number, :city, :state, :country)
	end
end