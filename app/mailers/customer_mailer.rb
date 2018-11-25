class CustomerMailer < ApplicationMailer
    def welcome_email(customer_id)
        @customer = Customer.find customer_id
        #attachments["sample.jpg"] = File.read("#{Rails.root}/app/assets/images/pineapple.jpg")
        mail(to: @customer.email, subject: "Welcome to My Food Ordering Site")
    end
    
    def reset_password(customer_id)
        @customer = Customer.find customer_id
        mail(to: @customer.email, subject: "Reset Password in My Food")
    end
    
    def order_confirmation(customer_id, order_id)
        @customer = Customer.find customer_id
        @order = Order.find order_id
        mail(to: @customer.email, subject: "My Food Order Confirmation")
    end
end
