Rails.application.routes.draw do
  root to: "home#index"

  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'home/index'

  # root "articles#index"

  get "/articles", to: "articles#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
