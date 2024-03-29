include ApplicationHelper

def valid_registro(user)
	fill_in "Email", with: user.email 
	fill_in "Password", with: user.password 
	click_button "Sign in"
end

def sign_up(user)
  visit signup_path
  fill_in "Name", with: user.name
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  fill_in "Confirmation", with: user.password_confirmation  
end

def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

RSpec::Matchers.define :have_error_message do |msg|
	match do |pg|
		pg.should have_selector('div.alert.alert-error', text: msg)
	end
end
#def titulo(page_title)
 # base_title = "Ruby on Rails Tutorial Sample App"
  #if page_title.empty?
   # base_title
  #else
   # "#{base_title} | #{page_title}"
  #end
#end