Rails.application.routes.draw do
  root to: "links#index"

  resources :links, only: [:index]
  
  get '/login_or_sign_up', to: 'welcome#index', as: 'welcome'

  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new', as: 'signup'
  post '/users' => 'users#create'

  namespace :api do
    namespace :v1 do
      resources :links, only: [:create, :update]
    end
  end
end
