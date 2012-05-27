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
end