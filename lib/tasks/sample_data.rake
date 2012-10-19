namespace :db do
	desc "Fill database with sample data"

	task populate: :environment do
		admin = User.create!(name: "Example User",
					email: "rakatongo@hotmail.com",
					password: "foobar",
					password_confirmation: "foobar")
		admin.toggle!(:admin)
		puts "Generando Usuarios"
		99.times do |i|
			name = Faker::Name.name
			email = "rakunb0t#{i}@example.com"
			password = "foobar"
			User.create!(name: name, email: email,
			password: password, password_confirmation: password)
			print "#{i} "
			puts "" if i == 98					    
		end
		users = User.all(limit: 6)
		puts "Generando comentarios"
		50.times do |i|
	      content = Faker::Lorem.sentence(5)
	      users.each { |user| user.microposts.create!(content: content) }
	      print "#{i} "
	      puts "" if i == 49
	    end
	end
end