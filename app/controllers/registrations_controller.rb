class RegistrationsController < Devise::RegistrationsController
  def update_resource(resource, params)
    # Register user to 2FA
    register_user_for_2fa(resource) unless resource.authy_enabled?

    # Check if user registered through facebook or google then it will ignore curren password on update
    if user_registered_through_provider?
      params.delete('current_password')
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

  def create
    # This is to overwrite creating user method from devise, required to register user 2FA
    super
    register_user_for_2fa(resource) unless resource.authy_enabled?
  end

  private

  def user_registered_through_provider?
    current_user.provider.present?
  end

  def register_user_for_2fa(resource)
    # Register user to authy 2FA and update authy_id, authy_enabled
    authy = Authy::API.register_user(
      email: resource.email,
      cellphone: resource.phone_number,
      country_code: resource.country_phone_code
    )
    return unless authy.present?
    resource.update authy_id: authy.id, authy_enabled: true
  end

  def sign_up_params
    # Overwrite devise signup params
    params.require(:user).permit(:email, :password, :password_confirmation, :phone_number, :country_code)
  end

  def account_update_params
    # Overwrite devise update params
    params.require(:user).permit(:username, :gender, :password, :country_code, :phone_number, :password_confirmation, :current_password)
  end
end
