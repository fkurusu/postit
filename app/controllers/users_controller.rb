class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, except: [:show]
  before_action :require_same_user, only: [:edit, :update]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Registration correct.'
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile updated."
      redirect_to @user
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :password)
    end

    def set_user
      @user = User.find_by(slug: params[:id])
    end

    def require_same_user
      unless @user == current_user
        flash[:error] = "You're not allowed to do that."
        redirect_to current_user
      end
    end
end
