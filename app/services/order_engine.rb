class OrderEngine
  def self.order(order_id, customer_id, menu_id, quantity)
    order = find_or_create_order(order_id, customer_id)
    order_item = update_or_create_order_item(order, menu_id, quantity)
    return order_id, order_item.menu.item, order_item.quantity
  end
  
  def self.find_or_create_order(order_id, customer_id)
    if order_id.present?
      order = Order.find order_id
    else
      order = Order.new(customer_id: customer_id)
      order.ordering_date = Date.today
      order.save
      #session[:order_id] = order.id
    end
    order
  end
  
  def self.update_or_create_order_item(order, menu_item_id, qty)
    order_item = order.order_items.find_by(menu_id: menu_item_id)
    if order_item.present?
      order_item.quantity += qty.to_i
    else
      order_item = order.order_items.new
      order_item.menu_id = menu_item_id
      order_item.quantity = qty
    end
    order_item.save 
    order_item
  end
end