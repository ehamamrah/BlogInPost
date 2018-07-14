class RegistrationsController < Devise::RegistrationsController
  def update_resource(resource, params)
    register_user_for_2fa unless @user.authy_enabled?
    if user_registered_through_provider?
      params.delete('current_password')
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

  private

  def user_registered_through_provider?
    current_user.provider.present?
  end

  def register_user_for_2fa
    authy = Authy::API.register_user(
      email: @user.email,
      cellphone: @user.phone_number,
      country_code: @user.country_phone_code
    )
    @user.update_attributes(authy_id: authy.id, authy_enabled: true)
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:username, :gender, :password, :country_code, :phone_number, :password_confirmation, :current_password)
  end
end
