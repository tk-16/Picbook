class LikesController < ApplicationController
  before_action :set_variables

  def like
    like = current_user.likes.new(book_id: @book.id)
    like.save
  end

  def unlike
    like = current_user.likes.find_by(book_id: @book.id)
    like.destroy
  end

  private

  def set_variables
    @book = Book.find(params[:book_id])
    @id_name = "#like-link-#{@book.id}"
  end

end
