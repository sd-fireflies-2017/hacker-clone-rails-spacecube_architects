class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :voter, class_name: "User"

  validates :voter, uniqueness: { scope: :votable }
end
