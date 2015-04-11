Rails.application.routes.draw do

  devise_for :users
  root to: 'feeds#index'
  post '/feeds/:id/bucket/:bucket_id' => 'feeds#bucket', as: :bucket_feed
  delete 'feeds/:id/bucket/:bucket_id' => 'feeds#unbucket', as: :unbucket_feed
  put '/reload-all' => 'feeds#reload_all', as: :reload_all_feeds
  put '/feeds/:id/reload' => 'feeds#reload', as: :reload_feed
  get '/splash' => 'home#splash', as: :splash
  resources :feeds

end
