class Api::OrderItemsController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def index
        order = Order.find_by(customer_id: session[:customer_id], is_checked_out: false)
        if order.present?
            session[:order_id] = order.id
            render json: order.order_items
        else
            session[:order_id] = nil
            render json: []
        end
    end
    
    def update
        order = Order.find session[:order_id]
        order_item = order.order_items
        order_item_machine = OrderItemMachine.new(order_item: order_item, situation_id: 1)
        order_item_machine.manage_quantity
        render json: { message: "You have increased the quantity of #{ order_item.menu.item }." }
    end
end