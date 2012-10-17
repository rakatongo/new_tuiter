require 'spec_helper'

describe "Auth Pages" do
  subject { page }

  describe "signin page" do 
  	before { visit signin_path }

  	it { should have_selector('h1', text: "Sign in")}
  	it { should have_selector('title', text: "Sign in")}

  	describe "invalid info" do
  		before { click_button "boton" }
  		it { should have_selector('div.alert.alert-error',text: "Invalid")}

  		describe "after visit another page" do

  		before { click_link "Home" } 
	  		it { should_not have_selector('div.alert.alert-error',text: "Invalid")}
	  	end
  	end

  	describe "with valid info" do  		
  		let(:user){ FactoryGirl.create(:user)}
  		before { valid_registro(user) } 
  		it { should have_selector('title', text: user.name)}
  		it { should have_link('Profile', href: user_path(user))}
  		it { should have_link('Sign out', href: signout_path)}
  		it { should_not have_link('Sign in', href: signin_path)} 

  		describe "followed by signout" do
  			before { click_link "Sign out" }	
  			it { should have_link('Sign in')}
  		end
  	end
  	
  end
end
