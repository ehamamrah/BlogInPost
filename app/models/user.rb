class User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy

  before_save :assign_role_to_user

  private

  def assign_role_to_user
    add_role(ROLES[:user])
  end
end
