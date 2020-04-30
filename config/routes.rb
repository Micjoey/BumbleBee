Rails.application.routes.draw do
  get 'worker_bees/index'
  root to: 'worker_bees#index'
  resources :worker_bees, only: [:index, :show, :update]
  resources :pollen_collections, only: [:create, :destroy]
  resources :supervisor_bees, only: [:create, :destroy]
  resources :combs, only: [:index, :show, :update]
end
