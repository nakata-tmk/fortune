class Admin::WordsController < ApplicationController
  before_action :authenticate_admin

  def show
    @word = Word.find(params[:id])
  end

  def destroy
    word = Word.find(params[:id])
    word.destroy
    redirect_to admin_top_path
  end
end
