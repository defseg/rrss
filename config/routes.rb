Rails.application.routes.draw do

  devise_for :users
  root to: 'feeds#index'
  put '/reload-all' => 'feeds#reload_all', as: :reload_all_feeds
  put '/feeds/:id/reload' => 'feeds#reload', as: :reload_feed
  get '/splash' => 'home#splash', as: :splash
  get '/app' => 'home#app', as: :app
  resources :feeds

  namespace :api do
    resources :feeds
  end

end
