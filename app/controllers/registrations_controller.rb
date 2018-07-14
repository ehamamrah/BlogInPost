class RegistrationsController < Devise::RegistrationsController
  def update_resource(resource, params)
    register_user_for_2fa unless resource.authy_enabled?
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
    authy = Authy::API.register_user(
      email: resource.email,
      cellphone: resource.phone_number,
      country_code: resource.country_phone_code
    )
    return unless authy.present?
    resource.update authy_id: authy.id, authy_enabled: true
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :phone_number, :country_code)
  end

  def account_update_params
    params.require(:user).permit(:username, :gender, :password, :country_code, :phone_number, :password_confirmation, :current_password)
  end
end
