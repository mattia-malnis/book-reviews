class BooksController < ApplicationController
  include Pagy::Backend
  include FindBook

  before_action :find_book, only: [ :show ]

  def index
    if params[:query].present?
      @books = Book.search_books(params[:query])
    else
      @books = Book.all
    end

    @books = @books.with_attached_image
    @pagy, @books = pagy(@books)
  end

  def show
    @reviews = @book.reviews.eager_load(:user, :votes)
    @pagy, @reviews = pagy(@reviews)
  end
end
