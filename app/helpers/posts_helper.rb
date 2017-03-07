module PostsHelper
  def voteUpvotes(post)
    post.votes.where(value: 1).count
  end

  def voteDownvotes(post)
    post.votes.where(value: -1).count
  end

  def voteNet(post)
    post.votes.sum(:value)
  end
end
