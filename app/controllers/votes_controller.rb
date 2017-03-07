class VotesController < ApplicationController
  include UsersHelper
  def index
    @vote = Vote.new(voter: current_user)
    @vote.votable = Post.find_by(id: params[:post_id])
    @vote.value = 1
    @vote.save
    redirect_to posts_path
  end

  def create
    @vote = Vote.new(voter: current_user)
    @vote.votable = Post.find_by(id: params[:post_id])
    @vote.value = -1
    @vote.save
    redirect_to posts_path
  end

  private
    def vote_params
      params.require(:vote).permit(:voter)

    end
end
