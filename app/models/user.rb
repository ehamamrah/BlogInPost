class User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[google facebook twitter]

  has_many :posts, dependent: :destroy

  validates :username, uniqueness: true

  after_save :assign_role_to_user

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  private

  def assign_role_to_user
    # assign a normal user previliges unless it's the first user
    add_role(ROLES[:user]) unless self == User.first
  end
end
