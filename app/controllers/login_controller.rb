#login controller
class LoginController < ApplicationController
  
  def new
  end

  def create
    @customer = Customer.find_by(email: params[:email], password: params[:password])
    if @customer.present?
      flash[:notice] = "You are log in successfully !"
      session[:customer_id] = @customer.id
      redirect_to orderings_path
    else
      flash[:alert] = "Email or password are incorrect ! Please try again."
      redirect_to action: :new
    end
  end
  
  def destroy
     session[:customer_id] = nil
     flash[:notice] = "You are log out successfully !"
     redirect_to orderings_path
  end
  
  def admin_login
    
  end
  
  def admin_session_id
    @admin = Admin.find_by(email: params[:email], password: params[:password])
    if @admin.present?
       flash[:notice] = "You are log in as admin successfully !"
       session[:admin_id] = @admin.id
       redirect_to admins_path
    else
      flash[:alert] = "Email or password are incorrect ! Please try again."
      redirect_to action: :admin_login
    end
  end
  
  def destroy_admin_id
     session[:admin_id] = nil
     flash[:notice] = "You are log out as admin successfully !"
     redirect_to action: :admin_login
  end
  
end
