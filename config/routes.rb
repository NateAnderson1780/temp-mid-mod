Rails.application.routes.draw do
  root to: 'home#index'
  
  get 'login_or_sign_up', to: 'welcome#index', as: 'welcome'
  
  get 'signup', to: 'users#new'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'

  resources :links, only: [:index, :create, :edit, :update]
  resources :users, only: [:create]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:create]
    end
  end
end
