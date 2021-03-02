Rails.application.routes.draw do
  get 'users/show'
  devise_for :users

  #エラー防止のために記述しています。
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
    get '/users/password', to: 'devise/passwords#new'
  end
  root to: "products#index"

  resources :products do
    resources :orders, only: [:create, :index]
  end

  resources :users, only: [:show]
end
