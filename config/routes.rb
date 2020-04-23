Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end

  resources :comments do
    resources :comments
  end

  get 'history', to: 'comments#history'

  devise_for :users
  root 'posts#index'
end
