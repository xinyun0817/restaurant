class OrderItemsController < ApplicationController
  before_action :authenticate_customer
  before_action :set_order_item, except: [:update_quantities]
  
  def update
    order_item_machine = OrderItemMachine.new(order_item: @order_item, situation_id: 1)
    flash[:order_notice] = order_item_machine.manage_quantity
    redirect_to orderings_path
  end
  
  def destroy
    order_item_machine = OrderItemMachine.new(order_item: @order_item, situation_id: 2)
    flash[:remove_notice] = order_item_machine.manage_quantity
    redirect_to orderings_path
  end
  
  def delete_order_item
    @order_item.destroy
    flash[:remove_notice] = "You have removed #{@order_item.menu.item} x #{@order_item.quantity}"
    redirect_back(fallback_location: orderings_path)
  end
  
  def update_quantities
    params[:order_item].each do | order_item_id, params_quantity |
      order_item = OrderItem.find order_item_id
      order_item_machine = OrderItemMachine.new(order_item: order_item, situation_id: 3, input_quantity: params_quantity[:quantity])
      order_item_machine.manage_quantity
    end
    flash[:notice] = "You have updated your order."
    redirect_to checkout_orderings_path
  end
  
  private
  
    def set_order_item
      order = Order.find params[:order_id]
      @order_item = order.order_items.find params[:id]
    end
end
