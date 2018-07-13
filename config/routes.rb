Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'callbacks' }

  root 'pages#home'
  resources :categories
  resources :posts
end
