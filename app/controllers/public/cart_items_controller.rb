class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total = 0
    @cart_items.each do |cart_item|
      @total += cart_item.subtotal
    end
  end

  def create
    if cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
      total_amount = cart_item.amount + cart_item_params[:amount].to_i
      if total_amount <= 10
        cart_item.update(amount: total_amount)
        flash[:notice] ="成功しました。"
        redirect_to cart_items_path
      else
        flash[:alert] ="1回の注文につき10個までです。"
        redirect_to cart_items_path
      end
    else
      cart_items = CartItem.new(cart_item_params)
      cart_items.customer_id = current_customer.id
      if cart_items.save
        flash[:notice] ="成功しました。"
        redirect_to cart_items_path
      else
        flash[:alert] = "失敗しました。"
        redirect_to item_path(params[:id])
      end
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    if cart_item.update(cart_item_params)
      flash[:notice] ="更新に成功しました。"
      redirect_to cart_items_path
    else
      @cart_items = current_customer.cart_items.all
      flash.now[:alert] = "更新に失敗しました。"
      render :index
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.destroy
      flash[:notice] ="削除に成功しました。"
      redirect_to cart_items_path
    else
      @cart_items = current_customer.cart_items.all
      flash.now[:alert] = "削除に失敗しました。"
      render :index
    end
  end

  def destroy_all
    cart_items = current_customer.cart_items
    if cart_items.destroy_all
      flash[:notice] ="削除に成功しました。"
      redirect_to cart_items_path
    else
      @cart_items = current_customer.cart_items.all
      flash.now[:alert] = "削除に失敗しました。"
      render :index
    end
  end

  private
    def cart_item_params
      params.require(:cart_item).permit(:amount, :item_id)
    end
end
