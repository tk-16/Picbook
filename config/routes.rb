Rails.application.routes.draw do
  get 'goods/search'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root to:'books#index'
  resources :books do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  
  resources :users, only: :show

  resources :goods, only: :search

  post   '/like/:book_id' => 'likes#like',   as: 'like'
  delete '/like/:book_id' => 'likes#unlike', as: 'unlike'

end
