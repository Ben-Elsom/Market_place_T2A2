Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'questions#index'
  resources :questions
  resources :comments
  post '/comments/:id/like', to: 'comments#like', as: 'like'
end
