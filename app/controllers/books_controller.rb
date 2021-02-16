class BooksController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :search]
  before_action :set_book, only: [:edit, :show]
  def index
    @books = Book.includes(:user).order("created_at DESC")
  end

  def new
    @book = Book.new
  end

  def create
    @book=Book.new(book_params)
    if @book.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @book.comments.includes(:user)
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
    redirect_to root_path
    end
  end

  def edit
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      redirect_to root_path
    end
  end

  def search
    @books = SearchBooksService.search(params[:keyword])
  end


  private
  def book_params
    params.require(:book).permit(:title, :story, :impression,:image).merge(user_id: current_user.id)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end
