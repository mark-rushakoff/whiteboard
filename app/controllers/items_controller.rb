class ItemsController < ApplicationController
  def create
    @item = Item.new(params[:item])
    if @item.save
      redirect_to '/'
    else
      render 'items/new'
    end
  end

  def new
    @item = Item.new
  end

  def index
    @items = Item.all.group_by { |i| i.kind }
    @blogable_items = Item.blogable.group_by { |i| i.kind }
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to '/'
  end

  def edit
    @item = Item.find(params[:id])
    render 'items/new'
  end

  def update
    @item = Item.find(params[:id])
    @item.update_attributes(params[:item])
    if @item.save
      redirect_to '/'
    else
      render 'items/new'
    end
  end
end