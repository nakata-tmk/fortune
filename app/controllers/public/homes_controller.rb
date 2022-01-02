class Public::HomesController < ApplicationController
  def top
    @sort_list = Word.sort_list
    if params[:sort].present?
      @words = Word.sort(params[:sort]).page(params[:page])
    else
      @words = Word.page(params[:page]).order(created_at: :desc)
    end
  end

  def about
  end
end
