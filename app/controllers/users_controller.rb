class UsersController < ApplicationController
  include UsersHelper

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    if logged_in? && current_user == @user
      render 'edit'
    else
      redirect_to new_session_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
        session[:user_id] = @user.id
        redirect_to posts_path
    else
        render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if logged_in? && current_user == @user
      redirect_to @user if @user.update(user_params)
    else
      redirect_to new_session_path
    end

  end

  def destroy
    @user = User.find(session[:user_id])
      if logged_in? && current_user == @user
        if @user
          @user.destroy
        else
          status 404
        end
      else
        redirect_to new_session_path
      end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :bio, :password)
    end

end
