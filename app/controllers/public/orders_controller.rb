class Public::OrdersController < ApplicationController
  def new
    @orders = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items
    @shipping_fee = 800
    @total = 0
    @cart_items.each do |cart_item|
      @total += cart_item.subtotal
    end
    @payment_method = order_params[:payment_method]
    case order_params[:select_address].to_i
    when 0
      @postal_code = current_customer.postal_code
      @address = current_customer.address
      @name = current_customer.name
    when 1
      address = Address.find(order_params[:address_id])
      @postal_code = address.postal_code
      @address = address.address
      @name = address.name
    when 2
      @postal_code = order_params[:postal_code]
      @address = order_params[:address]
      @name = order_params[:name]
    end
    @orders = Order.new
  end

  def create
    order = Order.new(order_params)
    order.customer_id = current_customer.id
    order.date = Time.current
    if order.save
      cart_items = current_customer.cart_items
      cart_items.each do |cart_item|
        order_detail  = OrderDetail.new
        order_detail.order_id = order.id
        order_detail.item_id = cart_item.item_id
        order_detail.amount  = cart_item.amount
        order_detail.price_inc_tax = cart_item.item.with_tax_price
        order_detail.save
        cart_item.destroy
      end
    else
      flash[:alert] = "ご注文の確定に失敗しました。"
    end
    redirect_to completion_order_path
  end

  def completion
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :select_address, :address_id, :postal_code, :address, :name, :price, :shipping_fee)
  end
end
