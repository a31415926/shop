class OrdersController < ApplicationController
  def basket
    order = current_order
    @items = order.order_items.includes(:product)
    @total_price_goods = order.total_price_goods
    @total_count_goods = order.total_count_goods
  end

  def checkout
  end

  private
end
