Rails.application.routes.draw do
  root 'welcome#index'

  # get     '/welcome'      to: 'welcome#index'
  get     '/signup',      to: 'users#new'
  get     '/login',       to: 'sessions#new'
  post    '/login',       to: 'sessions#create'
  delete  '/logout',      to: 'sessions#destroy'
  get     '/my_recipes',  to: 'users#recipes'

  resources :cuisines,  only: [:index, :show, :new, :create]
  resources :kinds,     only: [:index, :show, :new, :create]
  resources :recipes do
    get 'search', on: :collection
  end
  resources :sessions,  only: [:new, :create]
  resources :users,     only: [:index, :show, :new, :edit, :create, :update] do
    get 'recipes', on: :collection
  end
  resources :favorited_recipes, only: [:create, :destroy]
end
