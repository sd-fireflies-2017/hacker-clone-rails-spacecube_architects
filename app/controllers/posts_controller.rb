class PostsController < ApplicationController
  include UsersHelper, PostsHelper

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
      @post.author = current_user
      if @post.save
        redirect_to @post
      else
        render 'new'
      end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
      if logged_in? && current_user == @post.author
        @post.destroy
        redirect_to posts_path
      else
        redirect_to '/sessions/new'
      end
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :author)
    end

end
