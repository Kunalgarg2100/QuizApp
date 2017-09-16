Rails.application.routes.draw do



    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/leaderboard', to: 'static_pages#index'
  get  '/leaderboard/:subgenre', to: 'static_pages#show'


   get  '/signup',  to: 'users#new'
  #root 'application#hello'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  get    '/addques',   to: 'genres#new'
  post    '/addques',   to: 'genres#create'
  get    '/quiz',   to: 'questions#show'

  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
	resources :users
  resources :genres
  resources :subgenres 
  resources :questions 
end
