module ApplicationHelper
  def wordpress_enabled?
    !!(ENV['WORDPRESS_USER'] && ENV['WORDPRESS_PASSWORD'] && ENV['WORDPRESS_BLOG'])
  end

  def dynamic_new_item_path(opts={})
    @post ? new_post_item_path(@post, opts) : new_item_path(opts)
  end
end
