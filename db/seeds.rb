# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
posts=Post.create([
    {
        title:"test1",
        details:"detail1",
        category:"cat1",
        likes:0,
        name:"Zhanzhi"
    },
    {
        title:"test2",
        details:"detail2",
        category:"cat2",
        likes:0,
        name:"Zhanzhi"
    }
])

comments=Comment.create([
    {
    name:"Zijia",
    content:"Content1",
    likes:0,
    post:posts.first
    }
])
puts "Seeding Posts..."

puts "Seeding completed. Created #{Post.count} posts."
