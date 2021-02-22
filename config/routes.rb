Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tasks#index'
  resources :tasks do
    member do
      resources :task_labels, only: %i[new create destroy]
    end
  end
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout

  namespace :admin do
    resources :users, except: :show
    resources :tasks, only: :index
  end

  get '404', to: 'application#not_found'
  get '500', to: 'application#internal_error'
end
