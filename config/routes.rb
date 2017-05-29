Rails.application.routes.draw do
  devise_for :users

  root to: 'games#index'
  resources :games do
    resources :challenges, only: [:create, :delete]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
