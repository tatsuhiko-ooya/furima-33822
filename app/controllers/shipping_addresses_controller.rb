class ShippingAddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_address

  def edit

  end

  def update
    @shipping_address.update(shipping_address_params)
    if @shipping_address.valid?
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def find_address
    @shipping_address = ShippingAddress.find_by(user_id: current_user.id)
  end

  def shipping_address_params
    params.require(:shipping_address).permit(:post_code, :prefecture_id, :city, :building, :phone_number, :block).merge(user_id: current_user.id)
  end

end
