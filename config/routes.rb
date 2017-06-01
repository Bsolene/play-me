Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'games#index'
  resources :games do
    resources :challenges, only: [:create, :delete]
  end
  resources :users, only: [:show, :update] do
    patch '/mark-as-accepted', to: 'challenges#mark_as_accepted'
    patch '/decline', to: 'challenges#decline'
    resources :challenges, only: [:update]

  end
  get 'search', to: 'games#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
