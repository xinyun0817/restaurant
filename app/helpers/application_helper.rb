module ApplicationHelper
    
    def total_category
        Category.count(:id)
    end
    
    def total_menu
        Menu.count(:id)
    end
    
    def total_admin
        Admin.count(:id)
    end
    
    def total_order
        Order.count(:id)
    end
    
    def total_customer
        Customer.count(:id)
    end
    
    def two_decimals(price)
        sprintf('%.2f', price)
    end
    
    def is_active?(link_path)
      if current_page?(link_path)
        "active"
      else
        ""
      end
    end
    
    def active_if(controller_name)
      if params[:controller] == controller_name 
        "active"
      else
        ""
      end
    end
end
