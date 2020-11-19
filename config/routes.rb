Rails.application.routes.draw do
  get 'homes/top'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'

  resources :users, only: [:show,:index,:edit,:update]
end
