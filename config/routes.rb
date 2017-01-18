PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: :destroy do
    # nested resoruce /posts/3/comments
    resources :comments, only: :create
  end

  resources :categories, only: [:show, :new, :create]
end
