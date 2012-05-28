require 'spec_helper'

describe PostsController do
  it "routes send_email" do
    put("/posts/1/send_email").should route_to("posts#send_email", :id => "1")
  end
end
