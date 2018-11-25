class ForgottenPasswordController < ApplicationController
  def new
  end

  def create
    @customer = Customer.find_by(email: params[:email])
    if @customer.present?
      CustomerMailer.reset_password(@customer.id).deliver_now
      render :show
    else
      flash[:alert] = "Your email is invalid. Please try again."
      render :new
    end
  end

  def show
    @customer = Customer.find_by(email: params[:email])
  end
  
  def reset_password
    @customer = Customer.find_by(email: params[:email])
  end
  
  def update_password
    @customer = Customer.find_by(email: params[:email])
    if @customer.update(password_params)
      redirect_to login_path
      flash[:notice] = 'Your password has been successfully updated. Log in now to start your ordering.' 
    else
      render :reset_password
    end
  end
  
  def password_params
    params.require(:customer).permit(:password, :password_confirmation)
  end 
end
