class ApplicationController < ActionController::Base
  
  def authenticate_admin_user!
    return redirect_to new_user_session_path if current_user.nil?  
    return redirect_to root_path unless current_user.role_admin?
  end
end
