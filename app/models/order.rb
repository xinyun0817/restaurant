# == Schema Information
#
# Table name: orders
#
#  id             :bigint(8)        not null, primary key
#  ordering_date  :date
#  customer_id    :bigint(8)        not null
#  remark         :text(65535)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  is_checked_out :boolean          default(FALSE)
#

class Order < ApplicationRecord
    validates :ordering_date, :customer_id, presence: true
    
    belongs_to :customer
    has_many :order_items
    has_many :menus, through: :order_items
    
    def total_amount
        total = 0.00
        order_items.each do |order_item|
            total += order_item.quantity * order_item.menu.price
        end
        total
    end
end
