class ApplicationController < ActionController::Base
  include Pagy::Backend

  helper_method :current_order

  def current_order
    Order.find_or_create_by(user: current_user, status: Order.statuses[:in_progress])
  end

  def authenticate_admin_user!
    return redirect_to new_user_session_path if current_user.nil?  
    return redirect_to root_path unless current_user.role_admin?
  end
end
