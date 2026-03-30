Rails.application.routes.draw do
  get "categories/show"
  root "products#index"

  resources :products, only: [:index, :show]
end