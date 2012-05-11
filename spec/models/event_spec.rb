require 'spec_helper'

describe Event do

  before(:each) do
    @event = Factory(:event)
    @attr = { :content => "value for content", :title => "value for title", :summary => "value for summary", :date => 1.day.ago }
  end


  it "should create a new instance given valid attributes" do
    Event.create!(@attr)
  end


  describe "validations" do
    
    it "should require nonblank content" do
      Event.new(:content => "  ").should_not be_valid
    end

    it "should reject long title" do
      Event.new( :content => "a" * 51).should_not be_valid
    end
  end
end
