require 'spec_helper'

describe "items", :type => :request do
  it "creates an item" do
    visit '/items/new'
    fill_in 'item_title', :with => "IE8 doesn't work'"
    fill_in 'item_description', :with => "No, srsly.  It doesn't work"

    click_button 'Create Item'
    current_url.should == 'http://www.example.com/'
  end
end