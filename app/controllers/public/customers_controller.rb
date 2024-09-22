class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "更新に成功しました。"
      redirect_to mypage_path
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @customer = current_customer
    if @customer.update(is_active: "退会")
      sign_out @customer
      redirect_to root_path
    else
      render :unsubscribe
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end
end
