Rails.application.routes.draw do
  namespace :admin do
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    resource :admins, only: [:new, :create]
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
  end
end
