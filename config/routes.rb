Rails.application.routes.draw do  
  resources :messages, only: [:new, :create]
  get 'auth/:provider/callback' , to: 'sessions#create', protect_from_forgery: false
  get 'thoat' , to: 'sessions#destroy',as: :thoat
  get 'offline',to: 'sessions#offline'
  get 'online',to: 'sessions#online'

  root 'messages#new'
end
