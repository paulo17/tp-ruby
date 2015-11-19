Rails.application.routes.draw do
  root "pages#home"

  resources :users
  resources :posts

  get "about-this-class", to: "pages#about"
end
