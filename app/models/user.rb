require 'bcrypt'

class User < ActiveRecord::Base
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :votes, foreign_key: :voter_id

  validates :username, :email, :hashed_password, presence: true
  validate :password_cannot_be_blank

  def self.authenticate(args)
    user = User.find_by(email: args["email"])
    user = nil if user && user.password != args["password"]
    user
  end

  def password
    @password ||= BCrypt::Password.new(hashed_password)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.hashed_password = @password
  end

  private
    def password_cannot_be_blank
      errors.add(:password, 'can\'t be blank') if password == ''
    end
end
