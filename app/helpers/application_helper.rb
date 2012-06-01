module ApplicationHelper
  def wordpress_enabled?
    !!(ENV['WORDPRESS_USER'] && ENV['WORDPRESS_PASSWORD'] && ENV['WORDPRESS_BLOG'])
  end
end
