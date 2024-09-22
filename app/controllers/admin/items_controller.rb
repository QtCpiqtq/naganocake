class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
    if params[:item_name].present?
      @items = Item.where("name LIKE?", "%#{params[:item_name]}%")
    end
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "作成に成功しました。"
      redirect_to admin_item_path(@item.id)
    else
      @genres = Genre.all
      flash.now[:alert] = "作成に失敗しました。"
      render :new
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @genre = Genre.find(@item.genre_id)
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "更新に成功しました。"
      redirect_to admin_item_path(@item.id)
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end
  
  private
    def item_params
      params.require(:item).permit(:name, :introduction, :price, :is_active, :genre_id, :image)
    end
end
