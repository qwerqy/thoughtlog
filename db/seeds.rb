# Seed Users
user = {}
user['password'] = 'asdf'
# user['password_confirmation'] = 'asdf'

ActiveRecord::Base.transaction do
  20.times do
    user['first_name'] = Faker::Name.first_name
    user['last_name'] = Faker::Name.last_name
    user['email'] = Faker::Internet.email
    user['about'] = Faker::Lorem.paragraph(10)
    user['location'] = Faker::Address.city
    user['remote_avatar_url'] = Faker::LoremFlickr.image("300x300", ['people'])

    User.create(user)
  end
end
