require 'spec_helper'

describe "StaticPages" do

	let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "Home" do
  	it "should have el contentido 'Sample App' " do
  		visit '/static_pages/home'
  		page.should have_selector('h1',text: "Sample App")
  	end
  	it "should have the right title" do
	  visit '/static_pages/home'
	  page.should have_selector('title',
	                    :text => "#{base_title}")
	end

  end
  describe 'Help' do
  	it "should have el contenido 'Help'" do
  		visit '/static_pages/help'
  		page.should have_selector('h1',text:"Help")
  	end
  	it "should have the right title" do
	  visit '/static_pages/help'
	  page.should have_selector('title',
	                    :text => "#{base_title} | Help")
	end
  end
  describe 'About' do
  	it "should have el contenido 'About us' " do
  		visit '/static_pages/about'
  		page.should have_selector('h1',text:"About Us")
  	end
  	it "should have the right title" do
	  visit '/static_pages/about'
	  page.should have_selector('title',
	                    :text => "#{base_title} | About Us")
	end
  end

  describe "Contact page" do

    it "should have the h1 'Contact'" do
      visit '/static_pages/contact'
      page.should have_selector('h1', :text => 'Contact')
    end

    it "should have the title 'Contact'" do
      visit '/static_pages/contact'
      page.should have_selector('title', :text => "#{base_title} | Contact")
    end
  end
end
