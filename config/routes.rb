Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/check-session', to: 'sessions#check_session'
      resources :posts do
        resources :comments
      end
      resources :users
      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
    end
  end
end
