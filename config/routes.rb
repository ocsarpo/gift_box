Rails.application.routes.draw do
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
    resources :picked_nums, only: []
    resources :lotto_numbers, only: [:index, :show]
    resources :rounds, only: [:index, :show] do
      collection do
        get 'latest'
      end
    end

    get 'draw', to: 'draws#draw'
    get 'draw/random', to: 'draws#random'
  end

  namespace :admin do
    resources :picked_nums
    resources :lotto_numbers
    resources :rounds
    resources :rounds_imports, only: [:new, :create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'v1/rounds#index'
end
