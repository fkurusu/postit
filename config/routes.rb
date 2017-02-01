PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: :destroy do
    # nested resource /posts/3/comments
    resources :comments, only: :create
  end

  resources :categories, only: [:show, :new, :create]

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users, only: [:show, :create, :edit, :update]
  get '/register' => 'users#new'
end
