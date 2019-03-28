Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  resource :biometrics, only: [:show, :edit, :update, :create]
  root to: 'home#index'
end
