class ApplicationController < ActionController::Base
    helper_method :current_user
    def current_user
        if session[:customer_id].present?
            Customer.find_by(id: session[:customer_id])
        end
    end
    
    helper_method :current_admin
    def current_admin
        if session[:admin_id].present?
            Admin.find_by(id: session[:admin_id])
        end
    end

    def authenticate_customer
        if session[:customer_id].present?
        else
          flash[:alert] = "Please sign in as customer before continue"
          redirect_to login_path
        end
    end
    
    def authenticate_admin
       if session[:admin_id].present?
       else
          flash[:notice] = "Please sign in as admin before continue"
          redirect_to admin_login_path
       end
    end
end
