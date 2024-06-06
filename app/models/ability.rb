# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.is_admin?
      can :manage, :all # Admins can manage everything
    else
      # Define permissions for non-admin users
      can :read, Vehicle # Example: non-admin users can only read vehicles
      # Add more permissions as needed
    end
  end
end
