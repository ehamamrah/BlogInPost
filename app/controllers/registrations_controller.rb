class RegistrationsController < Devise::RegistrationsController

  def update_resource(resource, params)
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

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:username, :gender, :password, :password_confirmation, :current_password)
  end
end
