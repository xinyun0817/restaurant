class Api::MenuItemsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_token, except: [ :index ]
    
    def index
        if params[:category_id]
            menu_items = Menu.where(category_id: params[:category_id]).order(:position)
        else
            menu_items = Menu.joins(:category).order("categories.position, menus.position")
        end
        render json: menu_items
    end
    
    def create
        
        order_machine = OrderMachine.new(session[:order_id], session[:customer_id], params[:menu_id], params[:quantity])
      
        if order_machine.valid?
            order_machine.ordering
            session[:order_id] = order_machine.order.id
            message = "You have just ordered #{order_machine.menu.item} x #{order_machine.quantity}"
        else
            message = "You need a valid quantity"
            # status: 422
        end
        
        render json: { message: message }
    end
    
    def authenticate_token
       unless session[:customer_id].present?
           render json: { message: "Please log in first before continue." }, status: 401
       end
    end
end