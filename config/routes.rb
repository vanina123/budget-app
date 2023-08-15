Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  authenticated :user do
    root to: "categories#index", as: :authenticated_root
  end

  root to: 'home#splash'

  resources :categories, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :expenditures, only: [:index, :new, :create, :edit, :update, :destroy]

  end
end
