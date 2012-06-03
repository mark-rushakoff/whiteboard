class ItemsController < ApplicationController
  def create
    @item = Item.new(params[:item].merge(post_id: params[:post_id]))
    if @item.save
      redirect_to @item.post ? edit_post_path(@item.post) : '/'
    else
      render 'items/new'
    end
  end

  def new
    @post = Post.find_by_id(params[:post_id])
    @item = Item.new(params[:item])
    render_custom_item_template @item
  end

  def index
    @items = Item.orphans
    @public_items = Item.public.orphans
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to @item.post ? edit_post_path(@item.post) : '/'
  end

  def edit
    @item = Item.find(params[:id])
    render_custom_item_template @item
  end

  def update
    @item = Item.find(params[:id])
    @item.update_attributes(params[:item])
    if @item.save
      redirect_to @item.post ? edit_post_path(@item.post) : '/'
    else
      render_custom_item_template @item
    end
  end

  private

  def render_custom_item_template(item)
    if item.possible_template_name && template_exists?(item.possible_template_name)
      render item.possible_template_name
    else
      render "items/new"
    end
  end
end