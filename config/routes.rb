Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  resource :biometrics, only: [:edit, :update, :create]
  root to: 'home#index'
end
