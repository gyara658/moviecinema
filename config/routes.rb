Rails.application.routes.draw do
  devise_for :users ,controllers: {
    sessions: "users/sessions",
    passwords: "users/passwords",
    registrations: "users/registrations",
  }
  root to: 'movies#index'
  get "index_all", to: "movies#index_all"
  get "search", to: 'movies#search'
  get "movie/title", to: "movies#show"
  resource :movies , only: [:index, :show]
  resources :users, only: [:show]
  resources :posts, only: [:create, :edit, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
