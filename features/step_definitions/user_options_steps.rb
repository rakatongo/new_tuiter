Given /^a user visits de edit profile page$/ do
  @user = User.create(name: "Ejemlox", email: "user@cucumber.com",
  	password: "foobar", password_confirmation: "foobar")
  visit edit_user_path(@user)
end

When /^he submit invalid information$/ do
  click_button "Save changes"
end

Then /^he should see a error message$/ do
  page.should have_selector('div.alert.alert-error')
end

Given /^its the user has an account$/ do
  @user
end

Given /^its hes profile$/ do
  visit edit_user_path(@user)
end

When /^he submit valid information$/ do
  fill_in "Email", with: "nuevo@cucumber.com"
  fill_in "Password", with: "nuevopassword"
  fill_in "Confirmation", with: "nuevopassword"
  click_button "Save changes"
end

Then /^he should see a succes message$/ do
  page.should have_selector('div.alert.alert-success')
end
