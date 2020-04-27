# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# frozen_string_literal: true

Comment.destroy_all
Post.destroy_all
User.destroy_all

# Users

User.create!(
  id: 1,
  username: 'Bob',
  email: 'bob@mail.com',
  password: '123123',
  password_confirmation: '123123',
  admin: true
)

10.times do |u|
  User.create!(
    id: u + 2,
    username: Faker::Name.unique.first_name,
    email: Faker::Internet.unique.email,
    password: 'password',
    password_confirmation: 'password',
    admin: false
  )
end

# Posts

11.times do |i|
  post = Post.new
  post.title = "#{Faker::Hacker.ingverb.capitalize}
                #{Faker::Hacker.adjective}
                #{Faker::Hacker.verb}
                #{Faker::Hacker.noun}"

  article = Faker::Lorem.paragraph_by_chars(number: rand(500..2500))

  rand(5..10).times do
    article.insert(0, "#{Faker::Lorem.paragraph_by_chars(number: rand(500..1000))}<br/><br/>")
  end
  post.body = article

  post.user = User.first

  post.picture.attach(io: open('https://picsum.photos/900/300'), filename: "picture_#{i}.jpg")

  post.views = rand 1000

  post.save!

  # Comments

  rand(2..8).times do
    comment = post.comments.build(body: Faker::Lorem.paragraph_by_chars(number: 500),
                                  user: User.find(rand(1..10)))
    comment.save

    rand(1..5).times do
      nested_comment = comment.comments.build(body: Faker::Lorem.paragraph_by_chars(number: 500),
                                              user: User.find(rand(1..10)),
                                              reply: true)
      nested_comment.save
    end
  end
end
