Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post "login", to: "users#login"
  resources :owners 
  resources :theaters
  resources :screens
  resources :movies


  resource :customers 
  get "/search_movie", to: "customers#search_movie"
  resources :book_tickets
  get "tickets/search", to: "book_tickets#search_ticket"

  # resources :screens do
  #   get '/page/:page', action: :index
  # end


  

  


end
