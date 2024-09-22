class Public::ItemsController < ApplicationController
  def index
    @genre = Genre.all
    if params[:item_name].present?
      @items = Item.where("name LIKE?", "%#{params[:item_name]}%").page(params[:page]).order(created_at: :desc)
    elsif params[:genre_search].present?
      @items = Item.where(genre_id: params[:genre_search]).page(params[:page]).order(created_at: :desc)
    else
      @items = Item.page(params[:page]).order(created_at: :desc)
    end
  end

  def show
    @genre = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
