Rails.application.routes.draw do

  get 'admin/index'

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  resources :users
  resources :orders
  resources :line_items
  resources :carts
  root 'store#index' , as: "store_index"

  resources :product do 
    get :who_bought, on: :member
  end

  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
