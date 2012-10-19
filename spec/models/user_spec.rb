# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

require 'spec_helper'

describe User do
 before { @user = User.new(name: "Ejemplo", email: "rakunho@ejemplo.com",
 	password: "foobar",password_confirmation: "foobar")}

 subject { @user }

 it { should respond_to(:name)} 
 it { should respond_to(:email)}
 it { should respond_to(:password_digest)}
 it { should respond_to(:password)}
 it { should respond_to(:password_confirmation)}
 it { should respond_to(:authenticate)}
 it { should respond_to(:admin) }
 it { should respond_to(:remember_token)}
 it { should be_valid }
 it { should respond_to(:microposts) }
 it { should_not be_admin }

 describe "with admin attributte set to true" do
 	before do 
 		@user.save
 		@user.toggle!(:admin)
 	end
 	it { should be_admin } 
 end

 describe "check for remember_token is not nil" do
 	before { @user.save }
 	#it { @user.remember_token.should_not be_blank } 	
 	its(:remember_token){ should_not be_nil}
 end

 describe "when name is not present" do
 	before { @user.name = "" }
 	it { should_not be_valid }
 end

 describe "when email no esta presente" do
 	before { @user.email = " " }
 	it { should_not be_valid }
 end

 describe "cuando el nombre es muy largo " do
 	before { @user.name = "a" * 51 }
 	it { should_not be_valid }
 end

 describe "cuando email format no es valido" do
 	it "tiene que ser invalid" do
 	 	
	 	correos =  %w[user@foo,com user_at_foo.org example.user@foo.
	                     foo@bar_baz.com foo@bar+baz.com]
	    correos.each do |v|
	    	@user.email = v
	    	@user.should be_invalid
	    end
	end
 end
 describe "cuando el formato es valido" do
 	it "tiene que ser valido" do
 		correos =  %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
 		correos.each do |v|
 			@user.email = v 
 			@user.should be_valid
 		end
 	end
 end 
 describe "cuando el email ya esta tomado" do
 	before do
 		nuevo_usuario = @user.dup
 		nuevo_usuario.email = @user.email.upcase
 		nuevo_usuario.save
 	end
 	it { should_not be_valid }
 end

 describe "when password is not present" do
 	before { @user.password = @user.password_confirmation = " " }
 	it { should be_invalid }
 end
 describe "when password es nil" do
 	before { @user.password_confirmation = nil }
 	it { should be_invalid }
 end
 describe "return value of authenticate method" do
 	before { @user.save }
 	let(:found_user){ User.find_by_email(@user.email) }

 	describe "whit valid password" do
 		it { should == found_user.authenticate(@user.password)}
 	end
 	describe "with innvalid password" do
 		let(:user_for_invalid_password) { found_user.authenticate("PASSS INVALIDO")}
 		it { should_not == user_for_invalid_password }
 		specify{ user_for_invalid_password.should be_false }
 	end
 end
 #Micro post association
 describe "when micropost it back order" do
	before { @user.save }
    let!(:older_micropost) do 
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right microposts in the right order" do
      @user.microposts.should == [newer_micropost, older_micropost]
    end

    it "should destroy associated microposts" do
      microposts = @user.microposts.dup
      @user.destroy
      microposts.should_not be_empty
      microposts.each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end

  end  # <<<<  End Micrpost Association

end
