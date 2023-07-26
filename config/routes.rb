Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resource :users 
  post "login", to: "users#login"

  resources :theaters
  resources :screens
  patch "refresh/:id", to: "screens#refresh"

  resources :movies
  get "/search_movie", to: "movies#search_movie"

  resources :book_tickets
  get "tickets/search", to: "book_tickets#search_ticket"

  resources :shows



  

  


end
