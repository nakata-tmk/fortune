class Public::CommentsController < ApplicationController
  def create
    word = Word.find(params[:word_id])
    comment = Comment.new(comment_params)
    comment.word_id = word.id
    if comment.save
      redirect_to request.referer, notice: 'コメントしました'
    else
      redirect_to request.referer, alert: 'コメントを入力してください'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:word_id, :body)
    end
end
