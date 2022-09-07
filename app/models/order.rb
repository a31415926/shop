class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  enum status: %i[in_progress ordered canceled], _prefix: true

  def total_price_goods
    (order_items.map(&:sub_price).flatten.sum).round(2)
  end

  def total_count_goods
    order_items.map(&:cnt).flatten.sum
  end
end
