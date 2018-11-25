class PaymentController < ApplicationController
  before_action :authenticate_customer
  def index
  end
  
  def new
    @order = Order.find session[:order_id]
  end

  def create
    @customer = Customer.find session[:customer_id]
    @order = Order.find_by(id: session[:order_id], customer_id: session[:customer_id])
    CustomerMailer.order_confirmation(@customer.id, @order.id).deliver_now
    @order.is_checked_out = true
    @order.save
    session[:order_id] = nil
    redirect_to payment_index_path	
  end
end
