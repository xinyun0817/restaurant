class OrderMachine
  attr_reader :quantity, :menu
  attr_accessor :order
  
  def initialize(order_id, customer_id, menu_id, quantity)
    @order_id    = order_id
    @customer_id = customer_id
    @quantity    = quantity.to_i
    @menu        = Menu.find menu_id
  end
  
  def valid?
    if quantity > 0
      true
    else
      false
    end
  end
  
  def ordering
    if valid?
      find_or_create_order
      update_or_create_order_item
    end
  end
  
  private
  
  def find_or_create_order
    if @order_id
      self.order = Order.find @order_id
    else
      order = Order.new(customer_id: @customer_id)
      order.ordering_date = Date.today
      order.save
      self.order = order
      #session[:order_id] = order.id
    end
  end
  
  def update_or_create_order_item
    order_item = order.order_items.find_by(menu_id: menu.id)
    if order_item.present?
      order_item.quantity += quantity
    else
      order_item = order.order_items.new
      order_item.menu_id = menu.id
      order_item.quantity = quantity
    end
    order_item.save 
  end
end