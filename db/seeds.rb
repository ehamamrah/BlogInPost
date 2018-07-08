# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Creating [Admin] user
user_details = { email: 'example@example.com',
                 password: '123123123' }

@user = User.new(email: user_details[:email],
                 password: user_details[:password])

@user.add_role ROLES[:superadmin] if @user.save

# Creating Categories
5.times do
  Category.create(name: Faker::Book.genre,
                  status: CATEGORIES_STATUS[:active])
end
