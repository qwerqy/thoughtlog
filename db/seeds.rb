user = {}
user['password'] = '12345678'

ActiveRecord::Base.transaction do
	100.times do
		user['first_name'] = Faker::Name.first_name
		user['last_name'] = Faker::Name.last_name

    	user["email"] = Faker::Internet.email
    	user["remote_avatar_url"] = Faker::LoremFlickr.image("100x100", ['people'])
    	user["about"] = Faker::Hipster.paragraph
    	user["location"] = Faker::Address.country

		User.create(user)
	end
end

project = {}
user_ids = User.ids

ActiveRecord::Base.transaction do
	300.times do
		project['title'] = Faker::App.name
		project['description'] = Faker::Company.catch_phrase
		project['link'] = Faker::Internet.url
		project['remote_photo_url'] = Faker::LoremFlickr.image
		project['user_id'] = user_ids.sample

		Project.create(project)
	end
end

relationship = {}

ActiveRecord::Base.transaction do
	20.times do
		user_ids.each do |id|
			relationship['user_id'] = id
			relationship['follower_id'] = user_ids.sample
			Relationship.create(relationship)
		end
	end
end
