class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :item, null: false, index: {unique: true}
      t.decimal :price, null: false, precision: 5, scale: 2

      t.timestamps
    end
    
    add_reference :menus, :category, foreign_key: true, null: false
    
  end
end
