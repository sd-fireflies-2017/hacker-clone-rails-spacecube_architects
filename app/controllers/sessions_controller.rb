class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.authenticate(session_params)
    if @user
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      @user = User.new(session_params)
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to posts_path
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end

end
