class Admin::SessionsController < ApplicationController
  def new
    @admin = Admin.new
  end

  def create
    admin = Admin.find_by(email: session_params[:email])
    if admin&.authenticate(session_params[:password])
      session[:admin_id] = admin.id
      redirect_to admin_top_path, notice: '管理者権限でログインしました'
    else
      redirect_to admin_login_path, alert: 'ログインできません'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end

  private
    def session_params
      params.require(:admin).permit(:email, :password)
    end
end
