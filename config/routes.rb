Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'
  resources :categories
  resources :posts
end
