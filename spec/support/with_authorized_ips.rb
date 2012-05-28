module WithAuthorizedIps
  def with_authorized_ips(ips)
    old_value = AuthorizedIps::AUTHORIZED_IP_ADDRESSES
    Kernel::silence_warnings { AuthorizedIps.const_set('AUTHORIZED_IP_ADDRESSES', {sf: [IPAddr.new("127.0.0.1/27")]}) }

    yield

    Kernel::silence_warnings { AuthorizedIps.const_set('AUTHORIZED_IP_ADDRESSES', old_value) }
  end
end