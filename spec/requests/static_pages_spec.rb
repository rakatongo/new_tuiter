require 'spec_helper'

describe "StaticPages" do
	subject { page }	

  describe "Home" do
  	before { visit root_path }  	

  	it {should have_selector('h1',text: "Sample App")}  	
  	it {should have_selector('title', :text => titulo(''))}  	
  	it {should_not have_selector('title', :text => titulo('Home'))}  	

  end

  describe 'Help' do
  	before{ visit help_path }

  	it {should have_selector('h1', text: "Help")}
  	it {should have_selector('title', :text => titulo('Help'))}  	
  end

  describe 'About' do
  	before {visit about_path }  	

  	  it {page.should have_selector('h1',text:"About Us")}	
	  it {page.should have_selector('title',:text => titulo('About Us'))}	
  end

  describe "Contact page" do
  	before { visit contact_path }

      it {page.should have_selector('h1', :text => 'Contact')}      
      it {page.should have_selector('title', :text => titulo('Contact'))}
    
  end
end
