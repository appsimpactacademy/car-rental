class Owners::BookingsController < OwnersController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = Booking.includes(:vehicle, :user).where(vehicles: { owner_id: current_user.id }).order(created_at: :desc)
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.create(booking_params)
    if @booking.save
      redirect_to owners_bookings_path, notice: "Booking was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      redirect_to owners_bookings_path, notice: "Booking was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    redirect_to owners_bookings_path, notice: "Booking was successfully destroyed."
  end

  def accept
  	@booking = Booking.find(params[:id])
    @booking.update(status: 'accepted')
    render json: { message: 'Booking accepted.' }
  end

  def reject
  	@booking = Booking.find(params[:id])
    @booking.update(status: 'rejected')
    render json: { message: 'Booking rejected.' }
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(
      :user_id,
      :vehicle_id,
      :start_date,
      :end_date,
      :amount,
      :start_time,
      :end_time,
      :status
    )
  end
end
