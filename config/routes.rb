Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'questions#index'
  get 'questions/about', to: 'questions#about', as: 'about'
  get 'questions/closed_questions_index', to:'questions#closed_questions_index', as:"closed_questions_index"
  resources :questions
  resources :comments
  post '/comments/:id/like', to: 'likes#create', as: 'like'
  delete '/comments/:id/like', to: 'likes#destroy'
  get 'question/tie_breaker/:id', to: 'questions#tie_breaker', as: 'tie_breaker'
  post 'likes/final_likes/:id', to: 'likes#final_like', as: 'final_like'
end
