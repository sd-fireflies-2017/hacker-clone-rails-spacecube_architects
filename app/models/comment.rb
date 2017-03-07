class Comment < ActiveRecord::Base
 belongs_to :author, class_name: "User"
 belongs_to :post
 has_many :votes, as: :votable

 validates :body, :author_id, presence: true
end
