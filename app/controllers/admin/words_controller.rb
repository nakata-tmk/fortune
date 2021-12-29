class Admin::WordsController < ApplicationController
  def show
    @word = Word.find(params[:id])
  end

  def destroy
    word = Word.find(params[:id])
    word.destroy
    redirect_to admin_top_path
  end
end
