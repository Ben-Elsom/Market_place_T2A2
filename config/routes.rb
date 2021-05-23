Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'questions#index'
  resources :questions
  resources :comments
  post '/comments/:id/like', to: 'likes#create', as: 'like'
  delete '/comments/:id/like', to: 'likes#destroy'
  get 'question/tie_breaker', to: 'questions#tie_breaker'
end
