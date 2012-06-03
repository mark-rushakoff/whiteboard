require 'spec_helper'

describe SessionsController do
  it "routes to logout" do
    get("/logout").should route_to("sessions#destroy")
  end
end