class UsersController < ApplicationController
  def show
    @nickname = current_user.nickname
    @books = current_user.books
  end
end
