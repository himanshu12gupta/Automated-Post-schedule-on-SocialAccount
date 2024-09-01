Rails.application.routes.draw do
  resources :chats
  get 'calendars/index'
  resources :calendars, only: [:index]
  get 'admin/index'
   get 'admin', to: 'admin#index'
  resources :handlers
  resources :analytics
  resources :social_accounts
  # devise_for :users
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  root to: 'home#index'
  # get 'home', to: 'home#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    # delete 'logout', to: 'devise/sessions#destroy'
    get 'logout', to: 'devise/sessions#destroy'
    delete 'logout', to: 'devise/sessions#destroy'
  end
end
