class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.belongs_to :user, foreign_key: true
      t.float :amount, default: 0

      t.timestamps
    end
  end
end
