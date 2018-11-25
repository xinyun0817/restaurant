class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.date :ordering_date
      t.references :customer, foreign_key: true, null: false
      t.text :remark

      t.timestamps
    end
  end
end
