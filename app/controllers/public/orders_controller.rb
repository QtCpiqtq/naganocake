class Public::OrdersController < ApplicationController
  def new
    @order = current_customer.orders.build
  end

  def confirm
    @order = current_customer.orders.build(order_params)
    @cart_items = current_customer.cart_items
    @order.shipping_fee = 800
    #@total = 0
    @order.price = @cart_items.map { |cart_item| cart_item.subtotal }.sum
    #@payment_method = order_params[:payment_method]

    #case order_params[:select_address].to_i
    #when 0
    #  @order.postal_code = current_customer.postal_code
    #  @order.address = current_customer.address
    #  @order.name = current_customer.name
    #when 1
    #  address = Address.find(order_params[:address_id])
    #  @order.postal_code = address.postal_code
    #  @order.address = address.address
    #  @order.name = address.name
    #when 2
      #@postal_code = order_params[:postal_code]
      #@address = order_params[:address]
      #@name = order_params[:name]
    #end
    #@order = Order.new

    if !@order.valid?
      flash.now[:alert] = "failed"
      render :new
    end
  end

  def create
    order = current_customer.orders.build(order_params)
    order.date = Time.current
    if order.save
      flash[:notice] = "注文しました"
      #cart_items = current_customer.cart_items
      #cart_items.each do |cart_item|
      #  order_detail  = OrderDetail.new
      #  order_detail.order_id = order.id
      #  order_detail.item_id = cart_item.item_id
      #  order_detail.amount  = cart_item.amount
      #  order_detail.price_inc_tax = cart_item.item.with_tax_price
      #  order_detail.save
      #  cart_item.destroy
      #end
    else
      flash[:alert] = "ご注文の確定に失敗しました。"
    end
    redirect_to completion_order_path
  end

  def completion
  end

  def index
    @orders = current_customer.orders
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :select_address, :address_id, :postal_code, :address, :name, :price, :shipping_fee)
  end
end
