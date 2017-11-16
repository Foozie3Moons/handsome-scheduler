Rails.application.routes.draw do

  get 'auth/:provider/callback' => 'sessions#create'
  get 'auth/failure' => redirect('/')
  get 'signout' => 'sessions#destroy'

  resources :sessions, only: [:create, :destroy]
  resource :main, only: [:show]

  root 'main#index'

  get 'redirect' => 'main#redirect'
  get 'callback' => 'main#callback'
  get 'signout' => 'main#signout'
  get 'calendars' => 'calendars#index'
  get 'events/:calendar_id' => 'events#index', as: 'events', calendar_id: /[^\/]+/
  get 'events/:calendar_id/new' => 'events#new', as: 'new_events', calendar_id: /[^\/]+/
  post 'events/:calendar_id' => 'events#create', as: 'create_events', calendar_id: /[^\/]+/

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
