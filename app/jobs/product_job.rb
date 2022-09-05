class ProductJob < ApplicationJob
  queue_as :default

  def perform(*args)
    10.times do | |
      Product.create(
        title: Faker::Commerce.product_name, 
        price: Faker::Commerce.price
      )
    end
  end
end
