class AddIdTgToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :id_tg, :integer
  end
end
