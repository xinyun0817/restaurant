class OrderItemMachine
    attr_accessor :message
    
    def initialize(order_item:, situation_id:, input_quantity: 0)
        @order_item = order_item
        @situation_id = situation_id
        @input_quantity = input_quantity
    end
    
    def manage_quantity
        case @situation_id
        when 1
            @order_item.quantity += 1
            @order_item.save
            message = "You have increased the quantity of #{@order_item.menu.item}."
        when 2
            @order_item.quantity -= 1
            if @order_item.quantity == 0
                @order_item.destroy
                message = "You have removed #{@order_item.menu.item} x #{@order_item.quantity}"
            else
                @order_item.save
                message = "You have decreased the quantity of #{@order_item.menu.item}."
            end
        when 3
            if @input_quantity.to_i > 0
                @order_item.quantity = @input_quantity
                @order_item.save
            else
                @order_item.destroy
            end
        end     
    end
end