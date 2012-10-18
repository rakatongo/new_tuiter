Feature: Edit User
	Scenario: Unsusefull Edit
		Given a user visits de edit profile page
		When he submit invalid information
		Then he should see a error message
	Scenario: Succesfull Edit
		Given a user visits de edit profile page
		And its the user has an account
		And its hes profile
		When he submit valid information
		Then he should see a succes message