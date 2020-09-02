Rails.application.routes.draw do
  namespace :v1 do
    resources :picked_nums
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'v1/picked_nums#index'
end
