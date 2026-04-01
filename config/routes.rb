Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "products#index"

  resources :products
  resources :categories, only: [:show]

  get "cart", to: "cart#show"
  post "cart/add/:id", to: "cart#add", as: "add_to_cart"
end