Rails.application.routes.draw do
  devise_for :users, only: []

  namespace :v1 do
    resources :picked_nums
    resources :sessions, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'v1/picked_nums#index'
end
