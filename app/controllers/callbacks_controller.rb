class CallbacksController < Devise::OmniauthCallbacksController
  def facebook
    signin_and_redirect_user
  end

  def google_oauth2
    signin_and_redirect_user
  end

  private

  def signin_and_redirect_user
    @user = User.from_omniauth(request.env['omniauth.auth'])
    sign_in_and_redirect @user
    set_flash_message(:notice, :success, kind: retrieve_provider_name(request.env['omniauth.auth'].provider))
  end

  def retrieve_provider_name(provider)
    PROVIDERS[provider.to_sym][:name]
  end
end
