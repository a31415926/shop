class OrdersController < ApplicationController
  def basket
    order = current_order
    order_items = current_order.order_items
    @items = OrderItems::OrderItemsWithProductQuery.call(order_items, order_id: current_order.id)
    @total_price_goods = order.total_price_goods
    @total_count_goods = order.total_count_goods
  end

  def checkout
  end

  def update
    order = current_order
    if order.total_count_goods == 0
      flash[:error] = 'ERROR. Basket is empty!'
    else
      order.update(order_params)
      order.status_ordered!
      flash[:notice] = 'Order confirmed'
    end
    redirect_to root_path
  end

  private

  def order_params
    params.require(:order).permit(:email, :name, :phone, :address)
  end
end
