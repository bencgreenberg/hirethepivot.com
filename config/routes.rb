require "sidekiq/web"

Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/backend", :as => "rails_admin"
  devise_for :users

  resource :home, only: :show
  resource :about, only: :show, controller: :about
  resource :conduct, only: :show
  resource :pricing, only: :show, controller: :pricing
  resource :role, only: :new
  resources :businesses, except: :destroy
  resources :read_notifications, only: :index, path: "/notifications/read"
  resources :notifications, only: %i[index show]
  resources :conversations, only: %i[index show] do
    resources :messages, only: :create
    resource :block, only: %i[new create]
  end
  resources :developers, except: :destroy do
    resources :messages, only: %i[new create], controller: :cold_messages
  end

  namespace :stripe do
    resource :checkout, only: :show
    resource :portal, only: :show
  end

  namespace :admin do
    resources :conversations, only: :index
  end

  get "/privacy", to: "about#privacy", as: :privacy_page

  get "/terms", to: "about#terms", as: :terms_page

  root to: "home#show"

  authenticate :user, lambda { |user| SidekiqPolicy.new(user).visible? } do
    mount Sidekiq::Web => "/sidekiq"
  end
end
