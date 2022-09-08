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
end
