Rails.application.routes.draw do
  devise_for :users
  mount Attachinary::Engine => "/attachinary"

  root to: 'games#index'
  resources :games do
    resources :challenges, only: [:create, :delete]
  end
  resources :users, only: [:show, :update] do
    patch '/mark-as-accepted', to: 'challenges#mark_as_accepted'
  end
  get 'search', to: 'games#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
