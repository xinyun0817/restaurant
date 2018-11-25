class RemoveForeignKey < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :menus, :categories
    remove_foreign_key :order_items, :menus
    remove_foreign_key :order_items, :orders
    remove_foreign_key :orders, :customers
  end
end
