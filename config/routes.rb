Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: { registrations: "users/registrations" }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "books#index"

  resources :books, only: [ :show ] do
    resources :reviews, only: [ :new, :create, :edit, :update ], module: :books
  end

  resources :reviews, only: [] do
    member do
      post "vote-toggle-like", to: "votes#toggle_vote", defaults: { vote_type: "like" }, as: :toggle_like
      post "vote-toggle-dislike", to: "votes#toggle_vote", defaults: { vote_type: "dislike" }, as: :toggle_dislike
    end
  end

  scope "profile" do
    get "/", to: "profiles#show", as: :profile
    resources :reviews, only: [ :edit, :update ], module: :profiles, as: :profile_reviews
  end
end
