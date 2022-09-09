class ProductMailer < ApplicationMailer
  default from: "testuser@shop.com" 

  def changed_price
    @product = params[:product]
    @user = params[:user]

    mail(to: @user.email, subject: "Hello! New price for #{@product.title}")
  end 
end
