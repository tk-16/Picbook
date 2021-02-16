class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @books = user.books.order("created_at DESC").page(params[:page]).per(3)
  end
end
