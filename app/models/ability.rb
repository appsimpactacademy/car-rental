# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.is_admin?
      can :manage, :all # Admins can manage everything
    elsif user.is_owner?
      can :manage, Vehicle, owner_id: user.id # Owners can manage their vehicles
      can :read, Booking, vehicle: { owner_id: user.owner.id } # Owners can read bookings for their vehicles
      # can :manage, Booking, user_id: user.id # Owners can manage their own bookings
    else
      # Define permissions for non-admin users
      can :read, Vehicle # Example: non-admin users can only read vehicles
      # can :create, Booking # Non-admin users can create bookings
      # can :read, Booking, user_id: user.id # Non-admin users can read their own bookings
      # can :update, Booking, user_id: user.id # Non-admin users can update their own bookings
      # can :destroy, Booking, user_id: user.id # Non-admin users can delete their own bookings
      # Add more permissions as needed
    end
  end
end
