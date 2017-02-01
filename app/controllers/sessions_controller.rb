class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(name: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = 'Logged in successfully.'
      redirect_to root_path
    else
      flash[:error] = 'User/password incorrect(s)'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged out successfully.'
    redirect_to root_path
  end
end