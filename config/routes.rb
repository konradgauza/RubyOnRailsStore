Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resource :sign_up

  root "products#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :products do
    resources :subscribers, only: [ :create ]
  end
  resource :unsubscribe, only: [ :show ]
end
