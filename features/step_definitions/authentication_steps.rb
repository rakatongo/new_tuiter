Given /a user visits the signin page/ do
	visit signin_path
end
When /^he submits invalid signin information$/ do
  click_button "Sign in"
end
Then /^he should see an error message$/ do
	page.should have_selector('div.alert.alert-error')
end

Given /^a user visites the sigin page$/ do
  visit signin_path
end

Given /^the user has an account$/ do
  @user = User.create(name: "Ejemlox", email: "user@cucumber.com",
  	password: "foobar", password_confirmation: "foobar")
end

Given /^the user submits valid signin information$/ do
  fill_in "Email", with: "user@cucumber.com"
  fill_in "Password", with: "foobar"
  click_button "Sign in"
end

Then /^he should see his profile page$/ do
	page.should have_selector('title', text: @user.name)
end

Then /^he should see a signout link$/ do
  page.should have_link("Sign out", href: signout_path)
end
