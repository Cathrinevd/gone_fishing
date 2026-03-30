Rails.application.routes.draw do
  get "categories/show"
  root "products#index"

  resources :products
  resources :categories, only: [:show]
end