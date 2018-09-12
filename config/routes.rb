Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root  'static#index'

  ## Users
  resources :users do
    get 'delete'                          => 'users#delete'
  end
  # -------------

  ## Assets
  # "assets" is a reserved root used by rails to serve img,css,...
  resources :assets, path: :items

  ## Sessions
  get     'login'                          => 'sessions#new'
  post    'login'                          => 'sessions#create'
  delete  'logout'                         => 'sessions#destroy'
  # -------------
end
