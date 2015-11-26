Rails.application.routes.draw do

  get 'home', to: 'pages#home', as: :home
  get 'about', to: 'pages#about', as: :about
  get 'random', to: 'pages#random', as: :random

end
