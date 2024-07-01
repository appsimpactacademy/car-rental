# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.is_admin?
      can :manage, :all # Admins can manage everything
    elsif user.is_owner?
      can :manage, Owner::Vehicle, owner_id: user.id # Owners can manage their vehicles
      can :read, Owner::Booking, vehicle: { owner_id: user.owner.id } # Owners can read bookings for their vehicles
      can :manage, Booking, user_id: user.owner.id # Owners can manage their own bookings
      # Define more permissions for owners as needed
    else
      can :read, Vehicle # Non-admin users can read vehicles
      can :manage, Booking, user_id: user.id # Non-admin users can manage their own bookings
      # Define more permissions for non-admin users as needed
    end
  end
end
