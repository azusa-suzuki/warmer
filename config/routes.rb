Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  root 'homes#top'
  get 'homes/about' => 'homes#about'

  resources :users, only: %i[show edit update]

  resources :invites do
    resource :invite_comments, only: %i[create destroy]
    resource :marks, only: %i[create destroy]
  end

  resources :posts do
    resource :post_comments, only: %i[create destroy]
    resource :favorites, only: %i[create destroy]
  end

  resources :notifications, only: %i[index destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
