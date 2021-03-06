Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'callbacks' }

  root 'pages#home'
  
  resources :categories

  resources :posts do
    resources :comments

    member do
      post :hide
      post :publish
    end

    resources :verifications do
      collection do
        post :generate_new_otp
      end
    end
  end
end
