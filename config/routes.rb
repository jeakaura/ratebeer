Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :places, only: [:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'breweries#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  get 'exit', to: 'sessions#destroy', as: :logout
  get 'toggle_activity/:id', to: 'breweries#toggle_activity', as: :toggle
  get 'toggle_user_activity/:id', to: 'users#toggle_user_activity', as: :toggle_user
  get 'breweries_destroy/:id', to: 'breweries#destroy', as: :delete_brew
  get 'beers_destroy/:id', to: 'beers#destroy', as: :delete_beer
  get 'beer_clubs_destroy/:id', to: 'beer_clubs#destroy', as: :delete_club
  get 'styles_destroy/:id', to: 'styles#destroy', as: :delete_style
  get 'places', to: 'places#index'
  post 'places', to: 'places#search'
  get 'beerlist', to: 'beers#list'
  get 'brewerylist', to: 'breweries#list'
end