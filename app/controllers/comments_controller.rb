class CommentsController < ApplicationController
  include UsersHelper

def new
  post = Post.find_by(id: params[:post_id])
  @comment = Comment.new
  @comment.post = post if post
end

def show
  @comment = Comment.find(params[:id])
end

def edit
  @comment = Comment.find(params[:id])
end

def update
  @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @post
    else
      render 'edit'
    end

end

def create
  @comment = Comment.new(comment_params)
  @comment.author = current_user
  @comment.post = Post.find(params[:post_id])
  if @comment.save
    redirect_to @comment.post
  else
    render 'new'
  end
end

def destroy
  @comment = Comment.find(params[:id])
    if logged_in? && current_user == @comment.author
      @comment.destroy
      redirect_to posts_path
    else
      redirect_to '/sessions/new'
    end

end


private
  def comment_params
      params.require(:comment).permit(:body, :author, :post)
  end



end
