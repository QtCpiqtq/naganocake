class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = current_customer.addresses.all
  end

  def create
    @address = current_customer.addresses.new(address_params)
    if @address.save
      flash[:notice] = "作成に成功しました。"
      redirect_to addresses_path
    else
      @addresses = current_customer.addresses.all
      flash.now[:alert] = "作成に失敗しました。"
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "更新に成功しました。"
      redirect_to addresses_path
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    if address.destroy
      flash[:notice] = "削除に成功しました。"
      redirect_to addresses_path
    else
      @address = Address.new
      @addresses = current_customer.addresses.all
      flash.now[:alert] = "削除に失敗しました。"
      render :index
    end
  end

  private
    def address_params
      params.require(:address).permit(:postal_code, :address, :name)
    end
end
