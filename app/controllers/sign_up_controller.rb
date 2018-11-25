class SignUpController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    respond_to do |format|
      if @customer.save 
        CustomerMailer.welcome_email(@customer.id).deliver_now
        format.html { redirect_to login_path }
        flash[:notice] = 'You are sign up successfully. Please sign in.' 
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def customer_params
    params.require(:customer).permit(:name, :address, :email, :contact_number, :password, :password_confirmation)
  end
end
