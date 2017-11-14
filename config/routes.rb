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
  get '/calendars/:calendar_id' => 'home#show', as: 'show', calendar_id: /[^\/]+/
  get '/events/:calendar_id' => 'home#events', as: 'events', calendar_id: /[^\/]+/
  post '/events/:calendar_id' => 'home#new_event', as: 'new_event', calendar_id: /[^\/]+/


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
