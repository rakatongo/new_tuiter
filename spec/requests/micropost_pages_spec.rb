require 'spec_helper'

describe "MicropostPages" do

	subject { page }

	describe "non loged in" do

    	it "should not see the post form" do
    		should_not have_content("Micropost")
    	end    	
    end

	
	let(:user){ FactoryGirl.create(:user)}
	before { sign_in user }

  describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
end
