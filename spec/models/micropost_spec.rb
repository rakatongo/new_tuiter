# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Micropost  do

  	let(:user){ FactoryGirl.create(:user)}

  	before { @mic = user.microposts.build(content: "Lorem ipsum") }

  	subject { @mic }

  	describe "Micropost object" do 
  		before { user.save }
  		it { should respond_to(:content)}
  		it { should respond_to(:user_id)} 
  		it { should respond_to(:user) }
  		its(:user) { should == user }
  		it { should be_valid }
  	end  

  	describe "attributes accesibility" do
  		it "should not allow acces to user_id" do
  			expect do
  				Micropost.new(user_id: user.id)
  			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  		end
  	end

  	describe "when user_id is not present" do
  		before { @mic.user_id = nil}
  		it { should be_invalid }
  	end

  	describe "when content is blank" do
  		before{ @mic.content = " "}
  		it { should be_invalid }
  	end

  	describe "when there are more than 140 chars" do
  		before { @mic.content = "a" * 141}
  		it { should be_invalid }
  	end
  	
end	# <<<<<<< End Micrpopost
