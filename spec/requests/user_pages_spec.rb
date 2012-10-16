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
  end
end
