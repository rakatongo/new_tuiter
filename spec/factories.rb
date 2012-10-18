FactoryGirl.define do
	
	factory :wuser, class: User do
		name "Example User"
        email "user@example11111111.com"
        password "foobar"
        password_confirmation "foobar"
    end
    factory :user, class: User do
		sequence(:name){|n| "Person #{n}" }
		sequence(:email){|n| "rakatongo#{n}@hotmail.com"}
		password  "foobar"
		password_confirmation "foobar"
	end
	factory :admin, class: User do
		name "Admin User"	
		email "admin@admin.com"
		password "foobar"
		password_confirmation "foobar"
      	admin true
    end
end
