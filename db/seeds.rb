user = {}
user['password'] = '12345678'

ActiveRecord::Base.transaction do
	40.times do
		user['first_name'] = Faker::Name.first_name
		user['last_name'] = Faker::Name.last_name

    	user["email"] = Faker::Internet.email
    	# user["remote_avatar_url"] = Faker::Avatar.image
    	user["about"] = Faker::Hipster.paragraph
    	user["location"] = Faker::Address.country

		User.create(user)
	end
end
