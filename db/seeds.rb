# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rails db:seed command (or created
# alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([
#     { name: 'Star Wars' },
#     { name: 'Lord of the Rings' }
#   ])
#   Character.create(name: 'Luke', movie: movies.first)

99.times do |n|
  password = 'i7kBoaYU'
  User.create!(
    name: Faker::Name.name,
    email: "example-#{n}@auth0.com",
    password: password,
    password_confirmation: password
  )
end

User.create!(
  name:  'joshcanhelp',
  email: 'josh@joshcanhelp.com',
  password: 'The_Banana_Farmer_02',
  password_confirmation: 'The_Banana_Farmer_02',
  is_admin: false,
  is_author: true
)

User.create!(
  name:  'joshcanauth0',
  email: 'josh.cunningham@auth0.com',
  password: 'j2EwNZ{>goUN9aqFMirj',
  password_confirmation: 'j2EwNZ{>goUN9aqFMirj',
  is_admin: true,
  is_author: true
)

20.times do
  Article.create!(
    title: Faker::Lorem.sentence,
    text: Faker::Lorem.paragraph(2),
    user_id: User.all.sample.id
  )
end
