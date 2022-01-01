class Admin::HomesController < ApplicationController
  def top
    @sort_list = Word.sort_list
    if params[:sort].present?
      @words = Word.sort(params[:sort])
    else
      @words = Word.all
    end
  end
end
