Rails.application.routes.draw do

  resources :cuisines, only: [:index, :show, :new, :create]
end
