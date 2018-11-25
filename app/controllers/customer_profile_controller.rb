class CustomerProfileController < ApplicationController
  before_action :authenticate_customer
  before_action :set_customer
  
  def index
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customer_profile_index_path 
      flash[:notice] = 'Personal details was successfully updated.' 
    else
      render :edit 
    end
  end
  
  def change_password
  end
  
  def update_password
    old_password = Customer.find_by(id: session[:customer_id], password: params[:old_password])
    if old_password.present?
      if @customer.update(password_params)
        redirect_to customer_profile_index_path
        flash[:notice] = 'Your password was successfully updated.' 
      else
        render :change_password 
      end
    else
      redirect_to customer_profile_change_password_path
      flash[:alert] = 'Your old password is incorrect.' 
    end
  end
  
  private
  def set_customer
      @customer = Customer.find session[:customer_id]
  end

  def password_params
      params.require(:customer).permit(:password, :password_confirmation)
  end
  
  def customer_params
      params.require(:customer).permit(:name, :address, :email, :contact_number)
  end
end
