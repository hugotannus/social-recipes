Rails.application.routes.draw do
  root 'welcome#index'

  # get     '/welcome'  to: 'welcome#index'
  get     '/signup',  to: 'users#new'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'

  resources :cuisines,  only: [:index, :show, :new, :create]
  resources :kinds,     only: [:index, :show, :new, :create]
  resources :recipes,   only: [:index, :show, :new, :edit, :create, :update]
  resources :users,     only: [:index, :show, :new, :edit, :create, :update]
  resources :sessions,  only: [:new, :create]
end
