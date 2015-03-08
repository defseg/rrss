Rails.application.routes.draw do

  devise_for :users
  root to: 'home#index'
  get '/splash' => 'home#splash', as: :splash
  resources :feeds

end
