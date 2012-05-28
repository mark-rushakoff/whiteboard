require 'spec_helper'

describe "items", :type => :request do
  it "creates an item" do
    mock_omniauth
    visit '/auth/google_apps/callback'
    visit '/'
    click_link 'Add New Face'
    fill_in 'item_title', :with => "Johnathon McKenzie"
    click_button 'Create Item'

    click_link 'Add Help'
    fill_in 'item_title', :with => "IE8 doesn't work"
    fill_in 'item_description', :with => "No, srsly.  It doesn't work"
    click_button 'Create Item'

    current_url.should == 'http://www.example.com/'

    fill_in 'post_title', with: 'Standup 05/28/2012: Epic Standup'
    click_button 'create-post'

    click_link 'Add Interesting'
    fill_in 'item_title', :with => "Rubyming 5.0 is Out"
    check 'item_blogable'
    click_button 'Create Item'

    find('.email_post').should have_content("Johnathon McKenzie")
    find('.email_post').should have_content("IE8 doesn't work")
    find('.email_post').should have_content("Rubyming 5.0 is Out")

    find('.blog_post').should_not have_content("Johnathon McKenzie")
    find('.blog_post').should_not have_content("IE8 doesn't work")
    find('.blog_post').should have_content("Rubyming 5.0 is Out")
  end
end