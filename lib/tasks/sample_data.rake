namespace :db do
	desc "Fill database with sample data"

	task populate: :environment do
		admin = User.create!(name: "Example User",
					email: "rakatongo@hotmail.com",
					password: "foobar",
					password_confirmation: "foobar")
		admin.toggle!(:admin)
		99.times do |i|
			name = Faker::Name.name
			email = "rakunb0t#{i}@example.com"
			password = "foobar"
			User.create!(name: name, email: email,
			password: password, password_confirmation: password)
			print "#{i} "
			puts "" if i == 98
		end
	end
end