class OrderItemsController < ApplicationController
  before_action :set_product

  def create
    if @order_item
      @order_item.increment!(:cnt)
    else
      @order_item = current_order.order_items.create(
        product_id: params[:product_id],
        price: Product.find(params[:product_id]).price
      )
    end

    redirect_to root_path, notice: "#{@order_item.product.title} add to cart"
  end

  def update
    @order_item[:cnt] = params[:cnt]
    flash.alert = @order_item.errors unless @order_item.save

    redirect_to basket_orders_path
  end

  def destroy
    flash.alert = @order_item.errors unless @order_item.destroy

    redirect_to basket_orders_path
  end

  private

  def set_product
    @order_item = current_order.order_items.find_by(product: params[:product_id])
  end
end
