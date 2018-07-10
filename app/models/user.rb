class User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy

  after_save :assign_role_to_user

  private

  def assign_role_to_user
    # assign a normal user previliges unless it's the first user
    add_role(ROLES[:user]) unless self == User.first
  end
end
