class Owners::BookingsController < OwnersController
  before_action :authenticate_user!
  before_action :set_booking, only: [:destroy, :accept, :reject]

  def index
    @bookings = Booking.includes(:vehicle, :user)
                       .where(vehicles: { owner_id: current_user.id })
                       .order(created_at: :desc)
  end

  def destroy
    @booking.destroy
    redirect_to owners_bookings_path, notice: "Booking was successfully destroyed."
  end

  def accept
    update_booking_status('accepted', 'Booking accepted.')
  end

  def reject
    update_booking_status('rejected', 'Booking rejected.')
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def update_booking_status(status, message)
    @booking.update(status: status)
    render json: { message: message }
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
