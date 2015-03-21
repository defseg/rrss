Rails.application.routes.draw do

  devise_for :users
  root to: 'home#index'
  get '/reload-all' => 'feeds#reload_all', as: :reload_all_feeds
  get '/feeds/:id/reload' => 'feeds#reload', as: :reload_feed
  get '/splash' => 'home#splash', as: :splash
  resources :feeds

end
