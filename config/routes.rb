Rails.application.routes.draw do
  namespace :admin do
    get '/', to: 'homes#top', as: 'top'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    resource :admins, only: [:new, :create]
    resources :words, only: [:show, :destroy] do
    resources :comments, only: [:destroy]
    end
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'

    resources :words, only: [:index, :show, :new, :create] do
      resource :comments, only: [:create]
      resource :favorites, only: [:create]
    end
  end
end
