Rails.application.routes.draw do
  get 'rounds_imports/new'
  get 'rounds_imports/create'
  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'sessions',
      registrations: 'registrations'
    }

  namespace :v1 do
    resources :picked_nums, only: [:index]
    resources :lotto_numbers, only: [:index, :show]
    resources :sessions, only: [:create, :destroy]
    resources :rounds, only: [:index, :show]
  end

  namespace :admin do
    resources :picked_nums
    resources :lotto_numbers
    resources :rounds
    resources :rounds_imports, only: [:new, :create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'v1/lotto_nums#index'
end
