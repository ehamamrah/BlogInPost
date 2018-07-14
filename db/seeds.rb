# Creating [Admin] user
user_details = { email: 'example@example.com',
                 password: '123123123' }

@user = User.create(email: user_details[:email],
                    password: user_details[:password],
                    phone_number: 'xxxxxxxxx',
                    country_code: 'xx')

# Remove the default role granted before, make the user as super admin
@user.add_role ROLES[:superadmin]

# Creating Categories
5.times do
  Category.create(name: Faker::Book.genre,
                  status: CATEGORIES_STATUS[:active])
end

# Creating Posts
10.times do
  user     = User.order('RANDOM()').first
  category = Category.order('RANDOM()').first
  Post.create(user: user, category: category,
              title: Faker::Lorem.sentence,
              description: Faker::Lorem.sentence,
              content: Faker::Lorem.paragraph,
              status: POST_STATUS[:published])
end
