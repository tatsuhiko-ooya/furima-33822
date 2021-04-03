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
    collection do
      get 'search'
    end
    resources :orders, only: [:create, :index]
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :categories, only: [:index, :show] 
  resources :cards, only: [:new, :create]
  resources :shipping_addresses, only: [:edit, :update]

end
