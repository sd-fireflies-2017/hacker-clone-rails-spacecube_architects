class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  has_many :comments
  has_many :votes, as: :votable

  validates :title, :body, :author_id, presence: true

end
