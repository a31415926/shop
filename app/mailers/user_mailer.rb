class UserMailer < ApplicationMailer
  default from: "testuser@shop.com" 

  def welcome_mail
    @user = params[:user]

    mail(to: @user.email, subject: "Registration mail")
  end 
end
