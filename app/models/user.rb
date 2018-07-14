class User < ActiveRecord::Base
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :trackable, :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, uniqueness: true, on: :update
  validate :check_phone_number, unless: -> { omniauth_new_registration? }

  validates_presence_of :phone_number, :country_code, unless: -> { using_omniauth? }

  after_save :assign_role_to_user

  before_create :generate_random_username

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def country_phone_code
    # To get country international key number
    return unless country_code.present?
    country = ISO3166::Country[country_code]
    country.country_code || country.translations[I18n.locale.to_s]
  end

  def send_token_for_verification
    # Send OTP Number
    Authy::API.request_sms(id: authy_id)
  end

  private

  def using_omniauth?
    provider && uid
  end

  def omniauth_new_registration?
    new_record? && using_omniauth?
  end

  def assign_role_to_user
    # assign a normal user previliges unless it's the first user
    add_role(ROLES[:user]) unless self == User.first
  end

  def generate_random_username
    self.username = email
  end

  def check_phone_number
    errors[:phone_number] << I18n.t(:phone_number_incorrect) unless Phonelib.valid_for_country? phone_number, country_code
  end
end
