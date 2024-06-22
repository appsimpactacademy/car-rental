class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_owner_access
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = Booking.includes(:vehicle, :user).order(created_at: :desc)
  end

  def new
    @booking = Booking.new
    @booking = Booking.new(vehicle_id: params[:vehicle_id])
  end

  def create
    @booking = Booking.create(booking_params)
    if @booking.save
      BookingMailer.booking_notification_email(@booking.vehicle.owner, @booking).deliver_now
      redirect_to bookings_path, notice: "Booking was successfully created."
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
      redirect_to bookings_path, notice: "Booking was successfully updated."
    else
      render :edit, status: :unprocessable_entity         
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path, notice: "Booking was successfully destroyed."
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
      :end_time
      )
  end

  def check_owner_access
    if current_user.is_owner?
      redirect_to owners_dashboard_path, alert: "Unauthorized access"
    end
  end
end
