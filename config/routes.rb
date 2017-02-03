PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: :destroy do
    member do
      post :vote
    end
    # nested resource /posts/3/comments
    resources :comments, only: :create do
      member do
        post :vote
      end
    end
  end

  resources :categories, only: [:show, :new, :create]

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users, only: [:show, :create, :edit, :update]
  get '/register' => 'users#new'


end
