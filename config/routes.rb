Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  resource :biometrics, only: [:edit, :update, :create]
  resources :weight_logs, only: [:index, :create, :destroy, :update]
  resources :reminders, only: [:create, :destroy]
  root to: 'home#index'
end
