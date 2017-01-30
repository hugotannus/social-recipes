Rails.application.routes.draw do
  root 'recipes#index'

  get '/signup', to: 'users#new'

  resources :cuisines,  only: [:index, :show, :new, :create]
  resources :kinds,     only: [:index, :show, :new, :create]
  resources :recipes,   only: [:index, :show, :new, :create]
  resources :users,     only: [:index, :show, :new, :create]
end
