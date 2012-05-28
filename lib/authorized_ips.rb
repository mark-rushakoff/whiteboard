require 'ipaddr'

class AuthorizedIps
  AUTHORIZED_IP_ADDRESSES = ENV['AUTHORIZED_IP_ADDRESSES'] ? eval(ENV['AUTHORIZED_IP_ADDRESSES']) : {}

  def self.authorized_ip?(address)
    AUTHORIZED_IP_ADDRESSES.each_value.to_a.flatten.any? { |block| block.include?(address) }
  end

  def development?
    @request.env["REMOTE_ADDR"] == "127.0.0.1" && @request.env["HTTP_X_REAL_IP"].to_s == ""
  end
end