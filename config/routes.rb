Rails.application.routes.draw do

  get 'auth/:provider/callback' => 'sessions#create'
  get 'auth/failure' => redirect('/')
  get 'signout' => 'sessions#destroy'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  root 'home#index'

  get '/redirect' => 'home#redirect'
  get '/callback' => 'home#callback'
  get '/calendars' => 'home#calendars'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
