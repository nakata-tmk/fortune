class Public::FavoritesController < ApplicationController
  def create
    @word = Word.find(params[:word_id])
    favorite = Favorite.new(word_id: @word.id)
    favorite.save
  end
end
