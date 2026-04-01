Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "products#index"

  resources :products
  resources :categories, only: [:show]

  get "cart", to: "cart#show"
  post "cart/add/:id", to: "cart#add", as: "add_to_cart"
  delete "cart/remove/:id", to: "cart#remove", as: "remove_from_cart"
  patch "cart/update/:id", to: "cart#update_quantity", as: "update_cart"
end