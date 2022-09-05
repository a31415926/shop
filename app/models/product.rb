class Product < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories

  validates :title, presence: true

  has_many_attached :images do |img|
    img.variant :thumbnail, resize: "100x100"
    img.variant :large, resize: "300x300"
  end
end
