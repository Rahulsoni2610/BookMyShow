Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post "/owners/login", to: "owners#login"
  resources :owners 
  resources :theaters
  resources :screens
  resources :movies


  post "/customers/login", to: "customers#login"
  resources :customers 
  get "/search", to: "customers#search"
  resources :book_tickets
  get "tickets/search", to: "book_tickets#search"




  

  


end
