Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static#index'

  ## Users
  resources :users do
    get 'delete' => 'users#delete'
  end
  # -------------

  ## Assets
  # "assets" is a reserved root used by rails to serve img,css,...
  resources :assets, path: :items do
    post 'replace_battery'
    post 'archive'
  end

  ## Asset types
  resources :asset_types, path: :item_types

  ## Missions
  resources :missions do
    get 'prepare_assets'                      => 'missions#prepare_assets'
    post 'add_assets'                         => 'missions#add_assets'
    post 'remove_asset/:mission_asset_id'     => 'missions#remove_asset', as: :remove_asset
    delete 'extract_asset/:mission_asset_id'  => 'missions#extract_asset', as: :extract_asset

    ## Assets Missions
    resources :asset_mission
  end

  ## Sessions
  get     'login'                          => 'sessions#new'
  post    'login'                          => 'sessions#create'
  delete  'logout'                         => 'sessions#destroy'
  # -------------
end
