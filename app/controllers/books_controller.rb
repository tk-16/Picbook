class BooksController < ApplicationController
  def index
    @books = Book.all
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

  private
  def book_params
    params.require(:book).permit(:title, :story, :impression,:image)
  end

end
