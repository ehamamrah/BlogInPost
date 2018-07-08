class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role?(ROLES[:user])
      user_ability(user)
    elsif user.has_role?(ROLES[:superadmin])
      admin_ability
    else
      can :read, :all
    end
  end

  def user_ability(user)
    can :read, Post
    can %i[edit read update destroy create], Post, user_id: user.id

    cannot :manage, Category
    can :read, Category
  end

  def admin_ability
    can :manage, :all
  end
end
