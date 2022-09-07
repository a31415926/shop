class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.belongs_to :product, null: false
      t.belongs_to :order, null: false
      t.integer :cnt, default: 1

      t.timestamps
    end
  end
end
