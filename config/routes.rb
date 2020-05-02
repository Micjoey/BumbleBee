Rails.application.routes.draw do

  resources :worker_bees, except: [:destroy]
  resources :pollen_collections, only: [:create, :destroy]
  resources :supervisor_bees, only: [:create, :destroy]
  # resources :combs, only: [:index, :show, :update]

root 'worker_bees#index'
end
