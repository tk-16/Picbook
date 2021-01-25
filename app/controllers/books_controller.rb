class BooksController < ApplicationController
  def index
    @books = Book.includes(:user)
  end

  def new
    @book = Book.new
  end

  def create
    Book.create(book_params)
    
  end

  def show
    @book = Book.find(params[:id])   
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
    redirect_to root_path
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      redirect_to root_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :story, :impression,:image).merge(user_id: current_user.id)
  end

end
