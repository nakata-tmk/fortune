class Admin::HomesController < ApplicationController
  before_action :authenticate_admin

  def top
    @sort_list = Word.sort_list
    if params[:sort].present?
      @words = Word.sort(params[:sort]).page(params[:page])
    else
      @words = Word.page(params[:page]).order(id: :asc)
    end
  end
end
