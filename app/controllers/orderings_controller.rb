class OrderingsController < ApplicationController
  before_action :authenticate_customer, except: [ :index ]
  
  def index
    @order = Order.find_by(customer_id: session[:customer_id], is_checked_out: false)
    if @order
      session[:order_id] = @order.id
    else
      session[:order_id] = nil
    end
    
    @categories = Category.order(:position)
    
  end
  
  
  # def order
  #   if session[:customer_id].present?  
  #     order_id, menu_item_name, quantity = OrderEngine.order(session[:order_id], session[:customer_id], params[:menu_id], params[:quantity])
  #     session[:order_id] = order_id
  #     flash[:order_notice] = "You have just ordered #{menu_item_name} x #{quantity}"
  #     redirect_to action: :index
  #   else
  #     redirect_to orderings_path
  #     flash[:notice] = "Please log in before continue!"
  #   end
  # end
  
  # def order
  #   if session[:customer_id]
  #     order_machine = OrderMachine.new(session[:order_id], session[:customer_id], params[:menu_id], params[:quantity])
      
  #     if order_machine.valid?
  #       order_machine.ordering
  #       session[:order_id] = order_machine.order.id
  #       flash[:order_notice] = "You have just ordered #{order_machine.menu.item} x #{order_machine.quantity}"
  #       redirect_to action: :index
  #     end
  #   else
  #     redirect_to orderings_path
  #     flash[:alert] = "Please log in before continue."
  #   end
  # end
  
  def checkout
    @order = Order.find session[:order_id]
    
    # if @order.order_items.blank?
    #   flash[:notice] = "You have to order item first."
    #   redirect_to orderings_path
    # end
  end
  
end
