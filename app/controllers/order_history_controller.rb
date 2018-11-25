class OrderHistoryController < ApplicationController
  before_action :authenticate_customer
  
  def index
    @order = Order.where(customer_id: session[:customer_id])
  end

  def show
    @order = Order.find params[:id]
  end
  
end
