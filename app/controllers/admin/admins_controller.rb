class Admin::AdminsController < ApplicationController
  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to root_path, notice: '管理者権限で登録しました'
    else
      render :new
    end
  end

  private
    def admin_params
      params.require(:admin).permit(:email, :password, :password_comfirmation)
    end
end
