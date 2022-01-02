class ApplicationController < ActionController::Base
  helper_method :current_admin

  def authenticate_admin
    if current_admin == nil
      redirect_to admin_login_path, alert: 'ログインが必要です'
    end
  end

 private
   def current_admin
     @current_admin ||= Admin.find_by(id: session[:admin_id]) if session[:admin_id]
   end
end
