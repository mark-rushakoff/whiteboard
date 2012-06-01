class PostsController < ApplicationController
  def create
    @post = Post.new(params[:post])
    if @post.save
      @post.adopt_all_the_items
      redirect_to edit_post_path(@post)
    else
      flash[:error] = "An Error Occurred"
      redirect_to '/'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    if @post.save
      redirect_to edit_post_path(@post)
    else
      render 'posts/edit'
    end
  end

  def index
    @posts = Post.all
  end

  def send_email
    @post = Post.find(params[:id])
    if @post.sent_at
      flash[:error] = "The post has already been emailed"
    else
      @post.deliver_email
    end
    redirect_to edit_post_path(@post)
  end

  def post_to_blog
    @post = Post.find(params[:id])
    if @post.blogged_at
      flash[:error] = "The post has already been blogged"
    elsif !view_context.wordpress_enabled?
      flash[:error] = "Please set WORDPRESS_USER, WORDPRESS_PASSWORD and WORDPRESS_BLOG"
    else
      wordpress = WordpressService.new(:username => ENV['WORDPRESS_USER'], :password => ENV['WORDPRESS_PASSWORD'], :blog => ENV['WORDPRESS_BLOG'])
      wordpress.post(title: @post.title,
                     body: render_to_string(partial: 'items/as_markdown',
                                            layout: false,
                                            locals: {items: @post.public_items_by_type}) )
      @post.blogged_at = Time.now
      @post.save!
    end
    redirect_to edit_post_path(@post)
  end
end