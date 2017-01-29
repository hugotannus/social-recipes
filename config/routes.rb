Rails.application.routes.draw do
  root 'recipes#index'

  resources :cuisines,  only: [:index, :show, :new, :create]
  resources :kinds,     only: [:index, :show, :new, :create]
  resources :recipes,   only: [:index, :show, :new, :create]
end
