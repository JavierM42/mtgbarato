Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#home'

  get '/home', to: 'application#home', as: 'home'
  get '/info', to: 'application#info', as: 'info'
  get '/contact', to: 'application#contact', as: 'contact'
  
  get '/sell_catalog', to: 'sell_catalog#index', as: 'sell_catalog'
  get '/buy_catalog', to: 'buy_catalog#index', as: 'buy_catalog'

  resources :sell_listings, only: [:index, :create, :update, :destroy]
  resources :buy_listings, only: [:index, :create, :update, :destroy]
  resources :sell_listings_collection, only: [:update]
  resources :buy_listings_collection, only: [:update]
end
