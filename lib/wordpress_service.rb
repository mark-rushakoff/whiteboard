require 'xmlrpc/client'

class WordpressService
  def initialize(opts)
    @username = opts.delete(:username)
    @password = opts.delete(:password)
    @blog = opts.delete(:blog)
  end

  def connection
    XMLRPC::Client.new(@blog, '/xmlrpc.php')
  end

  def post(opts)
    post_hash = {
      'title'       => opts[:title],
      'description' => opts[:body],
      'mt_keywords' => opts[:keywords] || [],
      'categories'  => opts[:categories] || []
    }

    connection.call(
      'metaWeblog.newPost',
      1,
      @username,
      @password,
      post_hash,
      true
    )
  end
end