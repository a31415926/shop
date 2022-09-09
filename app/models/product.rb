class Product < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories

  validates :title, presence: true

  validates :images, dimension: { width: { min: 100, max: 3000 },
                                 height: { min: 120, max: 4500 }},
                      content_type: ['image/png', 'image/jpeg'],
                      limit: { max: 5 }

  has_many_attached :images do |img|
    img.variant :thumbnail, resize: "100x100"
    img.variant :large, resize: "300x300"
  end

  before_save :send_mail_with_change_price, if: :price_changed?

  private

  def send_mail_with_change_price
    User.joins(:orders => [:order_items]).where(orders: {status: :in_progress}, order_items: {product_id: self.id}).each do |user|
      ProductMailer.with(product: self, user: user).changed_price.deliver_now
    end
  end 
end
