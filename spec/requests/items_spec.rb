require 'spec_helper'

describe "items", type: :request, js: true do
  it "creates an item" do
    mock_omniauth
    visit '/auth/google_apps/callback'
    visit '/'
    find('a[data-kind="New face"] i').click
    fill_in 'item_title', :with => "Johnathon McKenzie"
    click_button 'Create New Face'

    find('a[data-kind=Help] i').click
    fill_in 'item_title', :with => "IE8 doesn't work"
    fill_in 'item_description', :with => "No, srsly.  It doesn't work"
    click_button 'Create Item'

    current_url.should match(/http:\/\/127\.0\.0\.1:\d*\//)

    page.execute_script "$.rails.confirm = function() { return true; }"
    fill_in 'post_title', with: 'Epic Standup'
    click_button 'create-post'

    find('a[data-kind=Interesting] i').click
    fill_in 'item_title', :with => "Rubymine 5.0 is Out"
    find("button:contains('Public')").click
    click_button 'Create Item'

    fill_in 'post_from', with: 'Matthew'
    click_button 'Update'

    find('.email_post').should have_content("From: Matthew")
    find('.email_post').should have_content("Johnathon McKenzie")
    find('.email_post').should have_content("IE8 doesn't work")
    find('.email_post').should have_content("Rubymine 5.0 is Out")

    find('.blog_post').should_not have_content("Johnathon McKenzie")
    find('.blog_post').should_not have_content("IE8 doesn't work")
    find('.blog_post').should have_content("Rubymine 5.0 is Out")
  end
end