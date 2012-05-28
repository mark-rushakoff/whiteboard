require 'spec_helper'

describe AuthorizedIps do
  it "can tell if a ip is authorized" do
    with_authorized_ips({sf: [IPAddr.new("127.0.0.1/32")]}) do
      AuthorizedIps.authorized_ip?('127.0.0.1').should == true
    end
  end
end