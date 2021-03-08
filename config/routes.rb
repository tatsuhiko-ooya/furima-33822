Rails.application.routes.draw do
  devise_for :users

  #エラー防止のために記述しています。
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
    get '/users/password', to: 'devise/passwords#new'
  end
  root to: "products#index"

  resources :products do
    member do
      get 'get_category_child', default: { format: 'json'}
      get 'get_category_grandchild', default: { format: 'json'}
    end
    resources :orders, only: [:create, :index]
  end

  resources :users, only: [:show, :edit, :update, :destroy]
  resources :categories, only: [:index, :show] 
end
