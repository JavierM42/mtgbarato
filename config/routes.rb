Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#home'

  get '/home', to: 'application#home', as: 'home'
  get '/contact', to: 'application#contact', as: 'contact'

  get '/sell_catalog', to: 'sell_catalog#index', as: 'sell_catalog'
  get '/buy_catalog', to: 'buy_catalog#index', as: 'buy_catalog'
  get '/products_catalog', to: 'products_catalog#index', as: 'products_catalog'

  resources :sell_listings, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :buy_listings, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :products, only: [:index, :new, :create, :edit, :update, :destroy]

  resources :users, only: [:show]

  get '/sell_listings_collection', to: 'sell_listings_collection#index', as: 'sell_listings_collection'
  post '/sell_listings_collection', to: 'sell_listings_collection#create', as: 'sell_listings_collection_create'
  put '/sell_listings_collection', to: 'sell_listings_collection#update', as: 'sell_listings_collection_update'


  get '/buy_listings_collection', to: 'buy_listings_collection#index', as: 'buy_listings_collection'
  post '/buy_listings_collection', to: 'buy_listings_collection#create', as: 'buy_listings_collection_create'
  put '/buy_listings_collection', to: 'buy_listings_collection#update', as: 'buy_listings_collection_update'
end
