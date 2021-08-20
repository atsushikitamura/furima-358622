class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :text, :category_id, :status_id, :delivery_fee_id, :prefecture_id, :delivery_period_id, :price).merge(user_id: current_user.id)
  end
end