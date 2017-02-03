class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Comment created."
      redirect_to @post
    else
      render 'posts/show'
    end
  end

  def vote
    comment = Comment.find(params[:id])
    vote = Vote.create(creator: current_user, vote: params[:vote], voteable: comment )
    
    vote.valid? ? flash[:notice] = 'Vote counted.' : flash[:error] = 'Vote already counted.'

    redirect_to :back
  end
end