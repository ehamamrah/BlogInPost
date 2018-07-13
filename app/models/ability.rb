class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role?(ROLES[:user])
      user_ability(user)
    elsif user.has_role?(ROLES[:superadmin])
      admin_ability
    else
      visitor_ability
    end
  end

  def user_ability(user)
    can :read, Post
    can :manage, Post, user_id: user.id

    cannot :manage, Category
    can :show, Category
  end

  def admin_ability
    can :manage, :all
  end

  def visitor_ability
    can :show, Category
    can %i[show read index], Post
  end
end
