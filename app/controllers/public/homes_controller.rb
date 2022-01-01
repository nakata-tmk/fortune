class Public::HomesController < ApplicationController
   def top
    @words = Word.all.order(created_at: :desc)
  end

  def about
  end
end
