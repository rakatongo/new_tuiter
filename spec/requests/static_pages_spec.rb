require 'spec_helper'

describe "StaticPages" do
	subject { page }	

  shared_examples_for "paginas estaticas" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: titulo(page_title)) }
  end

  describe "Home" do
  	before { visit root_path } 
  	let(:page_title){''} 	
  	let(:heading){ "Sample App" }  	
  	it_should_behave_like "paginas estaticas"
  	it {should_not have_selector('title', :text => titulo('Home'))}  	

  end

  describe 'Help' do
  	before{ visit help_path }
  	let(:page_title){'Help'} 	
  	let(:heading){ "Help" }

  	it_should_behave_like "paginas estaticas"
  end

  describe 'About' do
  	before {visit about_path }  	
  	let(:page_title){ 'About Us' }
  	let(:heading){ 'About Us' }
  	  it_should_behave_like "paginas estaticas"
  end

  describe "Contact page" do
  	before { visit contact_path }
  	let(:page_title){ 'Contact' }
  	let(:heading){ 'Contact' }
      it_should_behave_like "paginas estaticas"
  end
end
