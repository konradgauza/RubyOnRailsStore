Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resource :sign_up

  namespace :settings do
    resource :email, only: [ :show, :update ]
    resource :password, only: [ :show, :update ]
    resource :profile, only: [ :show, :update ]
    resource :user, only: [ :show, :destroy ]

    root to: redirect("/settings/profile")
  end

  namespace :email do
    resources :confirmations, param: :token, only: [ :show ]
  end

  # Admins Only
  namespace :store do
    resources :products
    resources :users

    root to: redirect("/store/products")
  end

  root "products#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :products do
    resource :wishlist, only: [ :create ], module: :products
    resources :subscribers, only: [ :create ]
  end
  resource :unsubscribe, only: [ :show ]

  resources :wishlists do
    resources :wishlist_products, only: [ :destroy ], module: :wishlists
  end
end
