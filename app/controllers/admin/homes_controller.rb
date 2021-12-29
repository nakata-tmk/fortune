class Admin::HomesController < ApplicationController
  def top
    @words = Word.all
  end
end
