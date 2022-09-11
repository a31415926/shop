class SendMailUserChangePriceJob < ApplicationJob
  queue_as :default

  def perform(params)
    product = params[:product]
    User.joins(:orders => [:order_items]).where(orders: {status: :in_progress}, order_items: {product_id: product.id}).each do |user|
      ProductMailer.with(product: product, price_was: params[:price_was], user: user).changed_price.deliver_later
    end
  end
end
