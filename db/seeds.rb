# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

ucount = 13
pcount = 37
ccount = 152
vcount = 507

needed_users = [0, ucount - User.count].max
needed_posts = [0, pcount - Post.count].max
needed_comments = [0, ccount - Comment.count].max
needed_votes = [0, vcount - Vote.count].max

needed_users.times do
  User.create!(
    username: Faker::TwinPeaks.character.gsub(' ', '_'),
    email: Faker::Internet.email(Faker::TwinPeaks.character.gsub(' ', '_')),
    password: 'password',
    bio: Faker::StarWars.wookie_sentence
  )
end

needed_posts.times do
  Post.create!(
    author: User.order('RANDOM()').first,
    title: Faker::TwinPeaks.quote,
    body: Faker::Hipster.paragraph
  )
end

needed_comments.times do
  Comment.create!(
    author: User.order('RANDOM()').first,
    post: Post.order('RANDOM()').first,
    body: Faker::Company.bs
  )
end

needed_votes.times do
  Vote.create!(
    voter: User.order('RANDOM()').first,
    votable: [Post.order('RANDOM()').first, Comment.order('RANDOM()').first].sample,
    value: [1, -1].sample
  )
end
