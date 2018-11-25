class CreateCategoriesMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_menus, id: false do |t|
      t.belongs_to :category, index: true
      t.belongs_to :menu, index: true
    end
  end
end
