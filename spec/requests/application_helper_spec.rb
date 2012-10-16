require 'spec_helper'

describe ApplicationHelper do

  describe "full_title" do
    it "should include the page title" do
      titulo("foo").should =~ /foo/ 
    end

    it "should include the base title" do
      titulo("foo").should =~ /^Ruby on Rails Tutorial Sample App/
    end

    it "should not include a bar for the home page" do
      titulo("").should_not =~ /\|/
    end
  end
end
