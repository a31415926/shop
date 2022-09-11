class ProductMailer < ApplicationMailer
  default from: "testuser@shop.com" 

  def changed_price
    @product = params[:product]
    @user = params[:user]
    @price_was = params[:price_was]

    mail(to: @user.email, subject: "Hello! New price for #{@product.title}")
  end 
end
