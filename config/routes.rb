Rails.application.routes.draw do
  root 'recipes#index'

  get     '/signup',  to: 'users#new'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'

  resources :cuisines,  only: [:index, :show, :new, :create]
  resources :kinds,     only: [:index, :show, :new, :create]
  resources :recipes,   only: [:index, :show, :new, :create]
  resources :users,     only: [:index, :show, :new, :create]
  resources :sessions,  only: [:new, :create]
end
