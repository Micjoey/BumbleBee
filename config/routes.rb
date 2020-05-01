Rails.application.routes.draw do
  # get 'worker_bees/index', to: 'worker_bees#index'
  # get 'worker_bees/:id', to: 'worker_bees#show'

# namespace :api, defaults: {format: :json} do
  resources :worker_bees
  resources :pollen_collections, only: [:create, :destroy]
  resources :supervisor_bees, only: [:create, :destroy]
  resources :combs, only: [:index, :show, :update]
# end
root 'worker_bees#index'
end
