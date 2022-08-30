class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  enum role: %i[customer admin], _prefix: true

  after_create :send_welcome_mail

  private

  def send_welcome_mail
    UserMailer.with(user: self).welcome_mail.deliver_now
  end

end
