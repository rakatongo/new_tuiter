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

      describe "afet submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Sign up') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      #let(:user){ FactoryGirl.create(:user)}
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@exampleuser.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "Should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      describe "after saving user" do
        before { click_button submit } 
        let(:user) { User.find_by_email('user@exampleuser.com')}
        it { should have_selector('title', text: user.name)}
        it { should have_selector('div.alert.alert-success', text: "Bienvenido a The Sample App!")}
        it { should have_link('Sign out') }
      end
    end
  end

  describe "Profile pages" do
    let(:user) { FactoryGirl.create(:user,email: "jej3@homa.com")}
    before { visit user_path(user) }
    it { should have_selector('h1', text: user.name)}
    it { should have_selector('title', text: user.name)}
  end

  describe "Edit Action" do
    let(:user) { FactoryGirl.create(:user)}
    before do
      sign_in user
      visit edit_user_path(user)
    end

    # Test para page Edit action
    describe "page" do
      it { should have_selector('h1',text: "Update your profile")}
      it { should have_selector('title', text: user.name)}
      it { should have_link('change', href: "http://gravatar.com/emails")}

      describe "With invalid info" do
        before { click_button "Save changes"}
        it { should have_content('error')}
      end 

      # LLenando formulario con valid input y clickeando aceptar
      describe "With Valid info" do
        let(:new_name) { "Un ejemplo"}
        let(:new_email) { "new@mail.com"}
        before do
          fill_in "Name", with: new_name
          fill_in "Email", with: new_email
          fill_in "Password", with: user.password 
          fill_in "Confirmation", with: user.password_confirmation
          click_button "Save changes"
        end
        it { should have_selector('title', text: new_name)}
        it { should have_selector('div.alert.alert-success')}
        specify { user.reload.name.should  == new_name }
        specify { user.reload.email.should == new_email } 
      end
    end
  end

  #_-------------------- Index page -------------
  describe "index" do

    let(:user){ FactoryGirl.create(:user) } 

    before(:each) do
      sign_in user 
      visit users_path
    end

    it { should have_selector('title', text: 'All users')}
    it { should have_selector('h1', text: 'All users')}

    describe "Pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user)}}
      after(:all){ User.delete_all }
      it "should list each user" do
        User.all.each do |user|
          page.should have_selector('li', text: user.name)
        end
      end    
    end
      #delete links
    describe "delete links" do
      it { should_not have_link('delete')}
      let(:admin){ FactoryGirl.create(:admin)} 
      before do
        sign_in admin
        visit users_path
      end
      describe "as admin user" do
        
        it "should see delete links" do
          should have_link("delete", href: user_path(User.first))
        end
        it "should be able to delete another user" do
          expect { click_link 'delete'}.to change(User, :count).by(-1)
        end

        it { should_not have_link('delete', user_path(admin.id))}

      end

      describe "as non-admin user" do
        let(:user) { FactoryGirl.create(:user) }
        let(:non_admin) { FactoryGirl.create(:user) }

        before { sign_in non_admin }

        describe "submitting a DELETE request to the Users#destroy action" do
          before { delete user_path(user) }
          specify { response.should redirect_to(root_path) }        
        end
      end
    end
  end
end
