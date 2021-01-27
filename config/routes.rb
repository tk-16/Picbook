Rails.application.routes.draw do
  devise_for :users
  root to:'books#index'
  resources :books do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  
  resources :users, only: :show

  post   '/like/:book_id' => 'likes#like',   as: 'like'
  delete '/like/:book_id' => 'likes#unlike', as: 'unlike'

end
