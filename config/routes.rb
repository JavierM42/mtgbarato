Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#home'

  get '/home', to: 'application#home', as: 'home'
  get '/info', to: 'application#info', as: 'info'
  get '/contact', to: 'application#contact', as: 'contact'
  
  get '/buy', to: 'buy#index', as: 'buy'
  get '/buy/edit', to: 'buy#edit', as: 'buy_edit'
  post '/buy/edit', to: 'buy#update', as: 'buy_update'

  get '/sell', to: 'sell#index', as: 'sell'
  get '/sell/edit', to: 'sell#edit', as: 'sell_edit'
  post '/sell/edit', to: 'sell#update', as: 'sell_update'

  resources :sell_listings, only: [:create, :update, :destroy]
  resources :buy_listings, only: [:create, :update, :destroy]
end
