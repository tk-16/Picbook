class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to "/books/#{comment.book.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, book_id: params[:book_id])
  end
end
