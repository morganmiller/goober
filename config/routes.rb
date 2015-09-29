Rails.application.routes.draw do
  root 'users#show'

  #refactor to namespace
  get '/signup' => 'users#new'
  get '/signup/rider' => 'users#rider_signup'
  get '/signup/driver' => 'users#driver_signup'
  resources :users, only: [:create]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
end
