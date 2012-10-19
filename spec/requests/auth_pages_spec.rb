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
      it { should_not have_link('Settings') }

  		describe "after visit another page" do

    		before { click_link "Home" } 
  	  		it { should_not have_selector('div.alert.alert-error',text: "Invalid")}
  	  	end
  	end

  	describe "with valid info" do  		
  		let(:user){ FactoryGirl.create(:user)}
  		before { valid_registro(user) } 
  		it { should have_selector('title', text: user.name)}
      it { should have_link('Users',    href: users_path) }
  		it { should have_link('Profile', href: user_path(user))}
      it { should have_link('Settings', href: edit_user_path(user)) }      
  		it { should have_link('Sign out', href: signout_path)}
  		it { should_not have_link('Sign in', href: signin_path)} 

  		describe "followed by signout" do
  			before { click_link "Sign out" }	
  			it { should have_link('Sign in')} 
  		end 
  	end  	
  end
  # Auth # >>>>>> Authorization
  describe "Authorization" do    

    describe "Non signed in users" do
      let(:user){ FactoryGirl.create(:user) }

        # Vistiando la pagina con Capybara ;) 
        describe "visiting edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title',text: 'Sign in')}
        end

        # Directamente en el controller
        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end

        describe "when attempting to visit a protected page" do
          before do 
            visit edit_user_path(user)
            sign_in(user)
          end 

          describe "after signin" do          
            it "should redirect_to desired page" do
              should have_selector('h1', text: "Update")
            end
          end
        end

        # Visitando users_path  = index
        describe "visiting user_path" do
          before { visit users_path }

          it { should have_selector('h1', text: 'Sign in')}
          it "should not have user list" do
            should_not have_selector('h1',text: 'All users')
          end
        end 
        
      describe "in the Microposts controller" do

        describe "submitting to the create action" do
          before { post microposts_path }
          specify { response.should redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end # <<<<<<<<< Authorization
#
    describe "as wrong user" do      
      let(:user){ FactoryGirl.create(:user) }
      let(:wrong) { FactoryGirl.create(:wuser)}  
      before do
        sign_in user
#        sign_in wrong
      end

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong) }
        it { should_not have_selector('h1', text: "Edit ")}        
      end

      describe "update action on controller" do
        before { put user_path(wrong)}
        specify { response.should redirect_to(root_path)}
      end
    end
    
  end

  
end
#describe "for non-signed-in users" do
 #     let(:user) { FactoryGirl.create(:user) }
#
 #     describe "in the Users controller" do
#
 #       describe "visiting the edit page" do
  #        before { visit edit_user_path(user) }
   #       it { should have_selector('title', text: 'Sign in') }
    #    end
#
 #       describe "submitting to the update action" do
  #        before { put user_path(user) }
   #       specify { response.should redirect_to(signin_path) }
    #    end
     # end
    #end