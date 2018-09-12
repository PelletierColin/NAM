Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root  'static#index'

  ## Users
  resources :users do
    get 'delete'                          => 'users#delete'
  end
  # -------------

  ## Sessions
  get     'login'                          => 'sessions#new'
  post    'login'                          => 'sessions#create'
  delete  'logout'                         => 'sessions#destroy'
  # -------------
end
