class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]

  def index
    @posts = Post.all.sort_by{ |v| v.up_votes }.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    if @post.save
      flash[:notice] = "Post created."
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post updated."
      redirect_to posts_path
    else
      render :edit
    end
  end

  def vote
    @vote = Vote.create(creator: current_user, vote: params[:vote], voteable: @post)

    respond_to do |format|
      format.html do
        @vote.valid? ? flash[:notice] = 'Vote counted.' : flash[:error] = 'Vote already counted.'
        redirect_to :back
      end

      format.js
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :url, :description, category_ids: [])
    end

    def set_post
      @post = Post.find(params[:id])
    end
end
