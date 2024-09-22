class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "更新に失敗しました。"
      redirect_to customer_path(@customer.id)
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end
  
  private
  def customer_params
    params.require(:customer).permit(:last_nane, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telepone_code, :email, :is_active)
  end
end
