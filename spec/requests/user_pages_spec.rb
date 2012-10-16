require 'spec_helper'

describe "UserPages" do
  subject { page }

  shared_examples_for "paginas de usuario" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: titulo(page_title)) }    
  end

  describe "Sign up " do
  	before { visit signup_path }
  	let(:page_title){ 'Sign up' }
  	let(:heading){ 'Sign up' }
  	it_should_behave_like "paginas de usuario" 
    let(:submit){ "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "Should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "Profile pages" do
    let(:user) { FactoryGirl.create(:user)}
    before { visit user_path(user) }
    it { should have_selector('h1', text: user.name)}
    it { should have_selector('title', text: user.name)}
  end
end
